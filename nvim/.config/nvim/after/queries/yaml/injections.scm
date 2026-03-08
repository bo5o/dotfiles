; extends

(block_mapping_pair
  key: (flow_node) @_dockerfile
  (#eq? @_dockerfile "dockerfile_inline")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "dockerfile")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_content
  (#eq? @_content "content")
  value: (block_node
    (block_scalar) @injection.content
    (#contains? @injection.content "#!/bin/sh")
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_content
  (#eq? @_content "content")
  value: (block_node
    (block_scalar) @injection.content
    (#contains? @injection.content "#!/bin/bash")
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_content
  (#eq? @_content "content")
  value: (block_node
    (block_scalar) @injection.content
    (#contains? @injection.content "#!/usr/bin/env sh")
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_content
  (#eq? @_content "content")
  value: (block_node
    (block_scalar) @injection.content
    (#contains? @injection.content "#!/usr/bin/env bash")
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))
