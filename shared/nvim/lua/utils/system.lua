local M = {}

-- System detection function
function M.is_nixos()
  local nixos_check = io.open("/etc/os-release", "r")
  if nixos_check then
    local content = nixos_check:read("*all")
    nixos_check:close()
    return content:match("nixos") or content:match("NixOS")
  end
  return false
end

return M