#!/bin/bash
#
#   Open vim to edit a temporary file and
#   load content into clipboard afterwards.

dir="/tmp/vim-anywhere/"
fn="$(date -Iseconds)"
[ ! -d $dir ] && mkdir $dir
nvim $dir$fn && cat $dir$fn | xsel -b -i
