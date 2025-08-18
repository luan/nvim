return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Add or skip cursor above/below the main cursor.
    set({ "n", "x" }, "<D-M-k>", function()
      mc.lineAddCursor(-1)
    end)
    set({ "n", "x" }, "<D-M-j>", function()
      mc.lineAddCursor(1)
    end)
    set({ "n", "x" }, "<D-M-S-k>", function()
      mc.lineSkipCursor(-1)
    end)
    set({ "n", "x" }, "<D-M-S-j>", function()
      mc.lineSkipCursor(1)
    end)

    -- Add or skip adding a new cursor by matching word/selection
    set({ "n", "x" }, "<D-d>", function()
      mc.matchAddCursor(1)
    end)
    set({ "n", "x" }, "<D-S-d>", function()
      mc.matchSkipCursor(1)
    end)
    set({ "n", "x" }, "<D-u>", function()
      mc.matchAddCursor(-1)
    end)
    set({ "n", "x" }, "<D-S-u>", function()
      mc.matchSkipCursor(-1)
    end)

    -- Add and remove cursors with control + left click.
    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    -- Disable and enable cursors.
    set({ "n", "x" }, "<c-q>", mc.toggleCursor)

    -- match new cursors within visual selections by regex.
    set("x", "M", mc.matchCursors)

    -- Split visual selections by regex.
    set("x", "X", mc.splitCursors)

    -- Pressing `gaip` will add a cursor on each line of a paragraph.
    set("n", "ga", mc.addCursorOperator)

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ "n", "x" }, "<D-k>", mc.prevCursor)
      layerSet({ "n", "x" }, "<D-j>", mc.nextCursor)

      -- Clone every cursor and disable the originals.
      set({ "n", "x" }, "<leader><c-q>", mc.duplicateCursors)

      -- Delete the main cursor.
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

      -- Align cursor columns.
      set("n", "<leader>a", mc.alignCursors)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { bg = "#7f849c" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
