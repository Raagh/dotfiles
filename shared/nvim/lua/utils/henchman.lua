local M = {}

local ROOT_PATTERN = "/henchman$"

-- Returns true if the given path is inside the henchman repo.
function M.is_henchman_project(path)
  if not path then
    return false
  end

  local git_root = vim.fs.find(".git", { path = path, upward = true })[1]
  if not git_root then
    return false
  end

  return vim.fs.dirname(git_root):match(ROOT_PATTERN) ~= nil
end

return M
