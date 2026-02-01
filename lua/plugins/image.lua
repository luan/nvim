return {
  "3rd/image.nvim",
  backend = "sixel", -- or "ueberzug" or "sixel"
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    processor = "magick_cli",
    scale_factor = 2.0,
  },
  config = function(_, opts)
    -- Patch document.lua to guard against invalid buffer IDs (BufNewFile race condition)
    local doc = require("image.utils.document")
    local orig_create = doc.create_document_integration
    doc.create_document_integration = function(config)
      local orig_nvim_create_autocmd = vim.api.nvim_create_autocmd
      vim.api.nvim_create_autocmd = function(events, autocmd_opts)
        if autocmd_opts.callback then
          local orig_cb = autocmd_opts.callback
          autocmd_opts.callback = function(args)
            if args.buf and not vim.api.nvim_buf_is_valid(args.buf) then return end
            return orig_cb(args)
          end
        end
        return orig_nvim_create_autocmd(events, autocmd_opts)
      end
      local result = orig_create(config)
      vim.api.nvim_create_autocmd = orig_nvim_create_autocmd
      return result
    end
    require("image").setup(opts)
  end,
}
