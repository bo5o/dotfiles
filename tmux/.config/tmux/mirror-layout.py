#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.10"
# dependencies = ["libtmux>=0.62"]
# ///
"""Mirror a tmux window layout left<->right (a natural left/right toggle).

Invoked from a tmux key binding as::

    run-shell '~/.config/tmux/mirror-layout.py #{window_id}'

It reads the target window's layout, flips it horizontally and feeds it back
via ``select-layout``. Mirroring is its own inverse, so pressing the key again
restores the original arrangement, and each app moves with its pane -- what was
on the left ends up on the right.

Two things happen:

1. Geometry -- every node's x-offset becomes ``window_width - x - width`` and the
   children of each horizontal (left/right) split are reversed so their order
   matches their new positions (tmux derives geometry from sibling order, not
   from the x-offsets alone). Widths, heights and y-offsets are untouched, so
   the single-column pane dividers keep lining up.

2. Contents -- ``select-layout`` fills the new cells with panes in the window's
   *current* order and ignores the pane ids in the layout string, so on its own
   it would scramble which app lands where. To make each app follow its pane to
   the mirrored slot, the window's pane list is first reordered (via
   ``swap-pane``) to match the mirrored tree's cell order.
"""

from __future__ import annotations

import re
import sys

from libtmux import Server, Window

_NODE = re.compile(r"(\d+)x(\d+),(\d+),(\d+)")
_INT = re.compile(r"\d+")


class _Parser:
    """Recursive-descent parser over the tmux layout grammar.

    node := WxH,X,Y ( '{' node (',' node)* '}'   # horizontal (left/right) split
                    | '[' node (',' node)* ']'   # vertical (top/bottom) split
                    | ',' pane_id )              # leaf pane
    """

    def __init__(self, s: str) -> None:
        self.s = s
        self.i = 0

    def parse(self) -> dict:
        m = _NODE.match(self.s, self.i)
        if not m:
            raise ValueError(f"bad layout near {self.s[self.i : self.i + 20]!r}")
        w, h, x, y = map(int, m.groups())
        self.i = m.end()
        node: dict = {"w": w, "h": h, "x": x, "y": y, "kids": []}
        c = self.s[self.i] if self.i < len(self.s) else ""
        if c in "{[":
            node["type"] = "h" if c == "{" else "v"
            close = "}" if c == "{" else "]"
            self.i += 1
            while True:
                node["kids"].append(self.parse())
                sep = self.s[self.i]
                self.i += 1
                if sep == close:
                    break
        else:  # ',' pane-id
            self.i += 1  # skip the comma
            m2 = _INT.match(self.s, self.i)
            if not m2:
                raise ValueError(f"bad pane id near {self.s[self.i : self.i + 20]!r}")
            node["type"] = "leaf"
            node["pane"] = m2.group()
            self.i = m2.end()
        return node


def _mirror(node: dict, ww: int) -> None:
    node["x"] = ww - node["x"] - node["w"]
    if node["type"] == "h":
        node["kids"].reverse()
    for kid in node["kids"]:
        _mirror(kid, ww)


def _serialize(node: dict) -> str:
    s = f"{node['w']}x{node['h']},{node['x']},{node['y']}"
    if node["type"] == "leaf":
        return f"{s},{node['pane']}"
    opening, closing = ("{", "}") if node["type"] == "h" else ("[", "]")
    return s + opening + ",".join(_serialize(k) for k in node["kids"]) + closing


def _checksum(s: str) -> int:
    """tmux layout checksum (layout_checksum() in tmux's layout-custom.c)."""
    csum = 0
    for byte in s.encode():
        csum = (csum >> 1) + (0x8000 if csum & 1 else 0)
        csum = (csum + byte) & 0xFFFF
    return csum


def _leaf_order(node: dict) -> list[str]:
    """Pane ids in the order tmux will fill cells (depth-first, as serialized)."""
    if node["type"] == "leaf":
        return [node["pane"]]
    order: list[str] = []
    for kid in node["kids"]:
        order.extend(_leaf_order(kid))
    return order


def mirror_layout(layout: str) -> tuple[str, list[str]]:
    """Mirror ``layout`` left<->right.

    Returns the new layout string (fresh checksum) and the pane-id order the
    window must be in for each app to land in its mirrored slot.
    """
    layout = layout.split(",", 1)[1]  # drop incoming checksum
    tree = _Parser(layout).parse()
    _mirror(tree, tree["w"])
    body = _serialize(tree)
    return f"{_checksum(body):04x},{body}", [f"%{p}" for p in _leaf_order(tree)]


def _reorder_panes(window: Window, desired: list[str]) -> None:
    """Permute the window's pane list into ``desired`` order via swap-pane.

    swap-pane exchanges both the contents and the list position of two panes, so
    a selection sort over pane ids lands every app where the mirrored layout
    expects it. Intermediate geometry is irrelevant -- select-layout fixes it.
    """
    panes = {p.pane_id: p for p in window.panes}
    cur = list(panes)
    for i, target in enumerate(desired):
        if cur[i] == target:
            continue
        j = cur.index(target, i + 1)
        panes[cur[i]].swap(panes[cur[j]])
        cur[i], cur[j] = cur[j], cur[i]


def main() -> int:
    # From the key binding tmux expands #{window_id} into argv; run by hand from
    # inside a pane, Window.from_env() resolves the window we're sitting in.
    win_id = sys.argv[1] if len(sys.argv) > 1 else None
    window = (
        Server.from_env().windows.get(window_id=win_id) if win_id else Window.from_env()
    )
    mirrored, desired = mirror_layout(window.window_layout)
    _reorder_panes(window, desired)
    window.select_layout(mirrored)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
