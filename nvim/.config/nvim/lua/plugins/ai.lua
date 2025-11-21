return {
  {
    "ravitemer/mcphub.nvim",
    keys = {
      { "<leader>om", "<cmd>MCPHub<cr>", desc = "Open MCP hub" },
    },
    opts = {},
  },

  {
    "Davidyz/VectorCode",
    version = "*",
    cmd = "VectorCode",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      async_backend = "lsp",
    },
  },

  {
    "olimorris/codecompanion.nvim",
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
    keys = {
      {
        "<leader>oa",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle AI chat",
        mode = { "n" },
      },
      {
        "<leader>fa",
        "<cmd>CodeCompanionHistory<cr>",
        desc = "Code companion history",
        mode = { "n" },
      },
      {
        "<leader>oa",
        ":CodeCompanionChat Add<cr>",
        desc = "Send to AI chat",
        mode = { "v" },
      },
      {
        "cra",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Select AI action",
        mode = { "n" },
      },
      {
        "<c-r>a",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Select AI action",
        mode = { "v" },
      },
      {
        "crc",
        ":CodeCompanion<space>",
        desc = "Code companion",
        mode = { "n" },
      },
      {
        "<c-r>c",
        ":CodeCompanion<space>",
        desc = "Code companion",
        mode = { "v" },
      },
    },
    opts = function()
      local default_adapter = vim.env.ANTHROPIC_API_KEY ~= nil and "anthropic"
        or "gemini"
      local title_model = default_adapter == "gemini" and "gemini-2.5-flash"
        or "claude-haiku-4-5-20251001"
      return {
        strategies = {
          chat = {
            adapter = default_adapter,
            keymaps = {
              send = {
                modes = { n = "<C-s>", i = "<C-s>" },
                index = 2,
                callback = "keymaps.send",
                description = "Send",
              },
            },
            roles = {
              llm = function(adapter)
                if not adapter.parameters then
                  return adapter.formatted_name
                end
                return string.format(
                  "%s%s",
                  adapter.formatted_name,
                  adapter.parameters.model and " (" .. adapter.parameters.model .. ")"
                    or adapter.schema.model.default
                )
              end,
            },
          },
          inline = { adapter = default_adapter },
          cmd = { adapter = default_adapter },
        },
        adapters = {
          http = {
            gemini = function()
              return require("codecompanion.adapters").extend("gemini", {
                schema = {
                  model = {
                    default = "gemini-3-pro-preview",
                  },
                },
              })
            end,
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              show_result_in_chat = true,
              make_vars = true,
              make_slash_commands = true,
            },
          },
          vectorcode = {
            opts = {
              tool_group = {
                -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
                enabled = true,
                -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
                -- if you use @vectorcode_vectorise, it'll be very handy to include
                -- `file_search` here.
                extras = {},
                collapse = false, -- whether the individual tools should be shown in the chat
              },
              tool_opts = {
                ["*"] = {},
                ls = {},
                vectorise = {},
                query = {
                  max_num = { chunk = -1, document = -1 },
                  default_num = { chunk = 50, document = 10 },
                  include_stderr = false,
                  use_lsp = true,
                  no_duplicate = true,
                  chunk_mode = false,
                  summarise = {
                    enabled = false,
                    adapter = nil,
                    query_augmented = true,
                  },
                },
                files_ls = {},
                files_rm = {},
              },
            },
          },
          history = {
            enabled = true,
            opts = {
              -- Keymap to open history from chat buffer (default: gh)
              keymap = "gh",
              -- Keymap to save the current chat manually (when auto_save is disabled)
              save_chat_keymap = "sc",
              -- Save all chats by default (disable to save only manually using 'sc')
              auto_save = true,
              -- Number of days after which chats are automatically deleted (0 to disable)
              expiration_days = 0,
              -- Picker interface (auto resolved to a valid picker)
              picker = "fzf-lua", --- ("telescope", "snacks", "fzf-lua", or "default")
              ---Optional filter function to control which chats are shown when browsing
              chat_filter = nil, -- function(chat_data) return boolean end
              -- Customize picker keymaps (optional)
              picker_keymaps = {
                rename = { n = "r", i = "<M-r>" },
                delete = { n = "d", i = "<M-d>" },
                duplicate = { n = "<C-y>", i = "<C-y>" },
              },
              ---Automatically generate titles for new chats
              auto_generate_title = true,
              title_generation_opts = {
                ---Adapter for generating titles (defaults to current chat adapter)
                adapter = nil, -- "copilot"
                ---Model for generating titles (defaults to current chat model)
                model = title_model, -- "gpt-4o"
                ---Number of user prompts after which to refresh the title (0 to disable)
                refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
                ---Maximum number of times to refresh the title (default: 3)
                max_refreshes = 3,
                format_title = function(original_title)
                  -- this can be a custom function that applies some custom
                  -- formatting to the title.
                  return original_title
                end,
              },
              ---On exiting and entering neovim, loads the last chat on opening chat
              continue_last_chat = false,
              ---When chat is cleared with `gx` delete the chat from history
              delete_on_clearing_chat = false,
              ---Directory path to save the chats
              dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
              ---Enable detailed logging for history extension
              enable_logging = false,

              -- Summary system
              summary = {
                -- Keymap to generate summary for current chat (default: "gcs")
                create_summary_keymap = "gcs",
                -- Keymap to browse summaries (default: "gbs")
                browse_summaries_keymap = "gbs",

                generation_opts = {
                  adapter = nil, -- defaults to current chat adapter
                  model = nil, -- defaults to current chat model
                  context_size = 90000, -- max tokens that the model supports
                  include_references = true, -- include slash command content
                  include_tool_outputs = true, -- include tool execution results
                  system_prompt = nil, -- custom system prompt (string or function)
                  format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
                },
              },

              -- Memory system (requires VectorCode CLI)
              memory = {
                -- Automatically index summaries when they are generated
                auto_create_memories_on_summary_generation = true,
                -- Path to the VectorCode executable
                vectorcode_exe = "vectorcode",
                -- Tool configuration
                tool_opts = {
                  -- Default number of memories to retrieve
                  default_num = 10,
                },
                -- Enable notifications for indexing progress
                notify = true,
                -- Index all existing memories on startup
                -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
                index_on_startup = false,
              },
            },
          },
        },
      }
    end,
  },
}
