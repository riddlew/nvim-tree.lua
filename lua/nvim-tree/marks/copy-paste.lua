local utils = require "nvim-tree.utils"
local core = require "nvim-tree.core"
local notify = require "nvim-tree.notify"
local copy_paste = require "nvim-tree.actions.fs.copy-paste"
local Marks = require "nvim-tree.marks"

local M = {}

function M.copy_marked_filename()
  local marks = Marks.get_marks()
  local nodes = {}

  if #marks == 0 then
    notify.info("Unable to copy, no files are marked.")
    return
  end

  for _, node in ipairs(marks) do
    table.insert(nodes, node.name)
  end

  copy_paste.copy_to_clipboard(nodes)
  notify.info(string.format("Copied %d filenames to neovim clipboard!", #marks))
end

function M.copy_marked_relative_path()
  local marks = Marks.get_marks()
  local nodes = {}

  if #marks == 0 then
    notify.info("Unable to copy relative paths, no files are marked.")
    return
  end

  for _, node in ipairs(marks) do
    local rel_path = utils.path_relative(node.absolute_path, core.get_cwd())
    local content = node.nodes ~= nil and utils.path_add_trailing(rel_path) or rel_path
    table.insert(nodes, content)
  end

  copy_paste.copy_to_clipboard(nodes)
  notify.info(string.format("Copied %d relative paths to neovim clipboard!", #marks))
end

function M.copy_marked_absolute_path()
  local marks = Marks.get_marks()
  local nodes = {}

  if #marks == 0 then
    notify.info("Unable to copy absoltue paths, no files are marked.")
    return
  end

  for _, node in ipairs(marks) do
    table.insert(nodes, node.absolute_path)
  end

  copy_paste.copy_to_clipboard(nodes)
  notify.info(string.format("Copied %d absolute paths to neovim clipboard!", #marks))
end

return M

