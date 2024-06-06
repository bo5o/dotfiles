local M = {}

function M.setup()
  require("lspconfig").dockerls.setup({ filetypes = { "Dockerfile", "dockerfile" } })
  -- require("lspconfig").docker_compose_language_service.setup({
  --   settings = {
  --     telemetry = {
  --       enableTelemetry = false,
  --     },
  --   },
  -- })
end

return M
