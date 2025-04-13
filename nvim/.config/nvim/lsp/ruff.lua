return {
  on_attach = function(client)
    -- disable hover in favor of pyright
    client.server_capabilities.hoverProvider = false
  end,
}
