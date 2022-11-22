local core = require "nvim-tree.core"
local renderer = require "nvim-tree.renderer"
local Iterator = require "nvim-tree.iterators.node-iterator"

local M = {}

function M.fn(node)
  if node.name == ".." then
    node = core.get_explorer()
  elseif node.type ~= "directory" then
    node = node.parent
  end

  Iterator.builder(node.nodes)
    :hidden()
    :applier(function(n)
      if n.nodes ~= nil then
        n.open = false
      end
    end)
    :recursor(function(n)
      return n.nodes
    end)
    :iterate()

  node.open = false
  renderer.draw()
end

return M
