; extends

(block_mapping_pair
  key: (flow_node) @_dockerfile
  (#eq? @_dockerfile "dockerfile_inline")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "dockerfile")
    (#offset! @injection.content 0 1 0 0)))

