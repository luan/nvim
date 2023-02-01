vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.o.foldcolumn = "1"
-- unfortunately this doesn't work well yet
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
  return
end

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

local function peek_or_hover()
  local winid = ufo.peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end

vim.keymap.set("n", "K", peek_or_hover)

ufo.setup {
  fold_virt_text_handler = handler,
  open_fold_hl_timeout = 0,
  provider_selector = function(bufnr, _, _)
    return function()
      local function handle_fallback_exception(err, providerName)
        if type(err) == "string" and err:match "UfoFallbackException" then
          return ufo.getFolds(providerName, bufnr)
        else
          return require("promise").reject(err)
        end
      end

      return ufo
          .getFolds("lsp", bufnr)
          :catch(function(err)
            return handle_fallback_exception(err, "treesitter")
          end)
          :catch(function(err)
            return handle_fallback_exception(err, "indent")
          end)
    end
  end,
}

vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)
