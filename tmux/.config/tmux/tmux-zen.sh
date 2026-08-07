#!/usr/bin/env bash
# Zen mode: show one pane centred on screen with blank padding to the left and right,
# then put it back exactly where it came from.
#
# The pane is moved into a dedicated session rather than a popup, so no nested tmux
# client is involved and there is nothing to get out of sync. A pane that is already
# alone in its window is padded in place instead, since there is nothing to break out.
#
# usage: tmux-zen.sh [toggle|on|off] [pane-id] [client]
#
# Options:
#   @zen_width         width of the reading column (default 100)
#   @zen_session       name of the session zen windows live in (default zen)
#   @zen_border_style  border style while in zen mode (default fg=colour237)

set -u

self=$(readlink -f "${BASH_SOURCE[0]}")
pad_cmd='sleep 2147483647'

# gopt <name> <default> -- read a global option, falling back to a default.
gopt() {
  local value
  value=$(tmux show -gv "$1" 2>/dev/null)
  printf '%s' "${value:-$2}"
}

# wopt <window> <name> -- read a window option, empty if unset.
wopt() { tmux show -wv -t "$1" "$2" 2>/dev/null; }

# Switch the client that asked for zen mode, not just any attached client.
switch_to() {
  if [ -n "$client" ]; then
    tmux switch-client -c "$client" -t "$1"
  else
    tmux switch-client -t "$1"
  fi
}

zen_on() {
  local win npanes layout before zsess zwin spare
  local width target pad left right border

  win=$(tmux display -pt "$pane" '#{window_id}')
  npanes=$(tmux display -pt "$pane" '#{window_panes}')

  if [ "$npanes" -gt 1 ]; then
    # Remember where the pane sat so it can be slotted back in later: the layout
    # restores the geometry, the neighbour restores the ordering.
    layout=$(tmux display -pt "$pane" '#{window_layout}')
    before=$(tmux list-panes -t "$win" -F '#{pane_id}' |
      awk -v p="$pane" '$0 == p { print prev; exit } { prev = $0 }')

    # A fresh session always comes with a window; keep it alive until the pane has moved
    # in, then drop it.
    zsess=$(gopt @zen_session zen)
    if tmux has-session -t "=$zsess" 2>/dev/null; then
      spare=
    else
      tmux new-session -ds "$zsess" \
        -x "$(tmux display -pt "$pane" '#{window_width}')" \
        -y "$(tmux display -pt "$pane" '#{window_height}')" || return 1
      spare=$(tmux list-windows -t "=$zsess" -F '#{window_id}' | head -1)
    fi

    tmux break-pane -ds "$pane" -n zen -t "=$zsess:" || return 1
    zwin=$(tmux display -pt "$pane" '#{window_id}')
    [ -n "$spare" ] && tmux kill-window -t "$spare"

    tmux set -wt "$zwin" @zen_origin "$win"
    tmux set -wt "$zwin" @zen_before "$before"
    tmux set -wt "$zwin" @zen_layout "$layout"
    # If the pane exits there is nothing left to restore.
    tmux set-hook -wt "$zwin" pane-exited "run-shell '$self cleanup $zwin'"

    switch_to "$zwin"
  else
    zwin=$win
  fi

  tmux set -wt "$zwin" @zen 1

  border=$(gopt @zen_border_style 'fg=colour237')
  tmux set -wt "$zwin" pane-border-style "$border"
  tmux set -wt "$zwin" pane-active-border-style "$border"

  # Two splits eat one border column each, so the pane keeps `target` columns.
  width=$(tmux display -pt "$pane" '#{window_width}')
  target=$(gopt @zen_width 100)
  pad=$(((width - target - 2) / 2))

  if [ "$pad" -ge 1 ]; then
    left=$(tmux split-window -hbd -l "$pad" -t "$pane" -PF '#{pane_id}' "$pad_cmd")
    right=$(tmux split-window -hd -l "$pad" -t "$pane" -PF '#{pane_id}' "$pad_cmd")
    tmux set -pt "$left" @zen_pad 1
    tmux set -pt "$right" @zen_pad 1
  fi

  tmux select-pane -t "$pane"
}

zen_off() {
  local zwin origin before layout osess content opanes first p

  zwin=$(tmux display -pt "$pane" '#{window_id}')
  origin=$(wopt "$zwin" @zen_origin)
  before=$(wopt "$zwin" @zen_before)
  layout=$(wopt "$zwin" @zen_layout)

  # Drop the hook first, otherwise killing the padding fires cleanup.
  tmux set-hook -uwt "$zwin" pane-exited 2>/dev/null
  for p in $(tmux list-panes -t "$zwin" -F '#{pane_id} #{@zen_pad}' |
    awk '$2 == 1 { print $1 }'); do
    tmux kill-pane -t "$p"
  done

  tmux set -uwt "$zwin" @zen
  tmux set -uwt "$zwin" pane-border-style
  tmux set -uwt "$zwin" pane-active-border-style

  # The pane was alone in its window, so it never moved.
  [ -n "$origin" ] || return 0

  content=$(tmux list-panes -t "$zwin" -F '#{pane_id}' | head -1)

  # The origin window or the old neighbour may have died in the meantime. Without the
  # window there is nowhere to go back to, so the zen window lives on as a plain window;
  # without the neighbour the pane goes in first.
  opanes=$(tmux list-panes -t "$origin" -F '#{pane_id}' 2>/dev/null)
  first=$(printf '%s\n' "$opanes" | head -1)
  [ -n "$first" ] || return 0
  printf '%s\n' "$opanes" | grep -qx -- "$before" || before=

  osess=$(tmux display -pt "$origin" '#{session_id}')

  # Move the client home before the pane, or the zen session losing its last window
  # would detach it.
  switch_to "$osess"

  # select-layout matches panes to cells in list order, so the pane has to go back at
  # its old position. join-pane -b would do it, but tmux never acts on the flag
  # (cmd-join-pane.c leaves `flags` at 0), so the pane always lands after the target and
  # a swap is needed when it belongs first.
  tmux join-pane -s "$content" -t "${before:-$first}" || return 1
  [ -n "$before" ] || tmux swap-pane -s "$content" -t "$first"

  tmux select-layout -t "$origin" "$layout" 2>/dev/null
  tmux select-window -t "$origin"
  tmux select-pane -t "$content"
}

# Called from the pane-exited hook: if only padding is left, bin the window.
cleanup() {
  local zwin=$1 origin osess left

  left=$(tmux list-panes -t "$zwin" -F '#{pane_id} #{@zen_pad}' 2>/dev/null |
    awk '$2 != 1' | wc -l)
  [ "$left" -eq 0 ] || return 0

  origin=$(wopt "$zwin" @zen_origin)
  if [ -n "$origin" ] && osess=$(tmux display -pt "$origin" '#{session_id}' 2>/dev/null); then
    switch_to "$osess"
    tmux select-window -t "$origin" 2>/dev/null
  fi
  tmux kill-window -t "$zwin" 2>/dev/null
  return 0
}

action=${1:-toggle}
# The binding passes #{pane_id}; tmux does not set TMUX_PANE for run-shell jobs, so
# there is nothing reliable to fall back on except the current pane.
pane=${2:-$(tmux display -p '#{pane_id}')}
client=${3-}

case "$action" in
cleanup) cleanup "$pane" ;;
off) zen_off ;;
on) zen_on ;;
toggle)
  if [ "$(tmux display -pt "$pane" '#{@zen}')" = 1 ]; then
    zen_off
  else
    zen_on
  fi
  ;;
*)
  echo "usage: ${0##*/} [toggle|on|off] [pane-id] [client]" >&2
  exit 1
  ;;
esac
