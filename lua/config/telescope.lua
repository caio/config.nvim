require('telescope').setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close
            },
        },
    },
    pickers = {
        find_files = {
            theme = "ivy",
            previewer = false
        },
        git_files = {
            theme = "ivy",
            previewer = false,
        },
        lsp_references = {
            theme = "cursor",
            previewer = false,
        },
        lsp_code_actions = {
            theme = "cursor",
        },
        buffers = {
            theme = "dropdown",
            previewer = false,
            sort_lastused = true,
            mappings = {
                i = {
                    ["<c-d>"] = "delete_buffer",
                },
            },
        },
        spell_suggest = {
            theme = "cursor"
        },
    },
})

function git_files_with_fallback()
    -- TODO Maybe restore the functionality where
    --      it would pass `-- path/to/current/buffer/directory`
    --      to `git ls-files` when outside of the repository root
    local opts = {}
    local ok = pcall(require'telescope.builtin'.git_files, opts)
    if not ok then require'telescope.builtin'.find_files(opts) end
end

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', "<leader>f", "<cmd>lua git_files_with_fallback()<CR>", opts)
map('n', "<leader>b", ":Telescope buffers<CR>", opts)
map('n', "z=", ":Telescope spell_suggest<CR>", opts)
