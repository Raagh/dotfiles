local ALLOWED_ROOT_DIRS = { "services", "packages", "scripts", "frontend" }
local IGNORED_DIRS = { "node_modules", ".git", "coverage", "dist" }
local HENCHMAN_ROOT_PATTERN = "/henchman$"

local function contains(list, value)
  for _, item in ipairs(list) do
    if item == value then
      return true
    end
  end
  return false
end

local function is_in_allowed_tree(path)
  for _, dir in ipairs(ALLOWED_ROOT_DIRS) do
    if string.find(path, "/" .. dir .. "/") then
      return true
    end
  end
  return false
end

local function normalize_rel_path(rel_path)
  if not rel_path then
    return ""
  end
  return rel_path:gsub("^%./", "")
end

local function is_henchman_allowed_path(rel_path)
  local normalized = normalize_rel_path(rel_path)
  if normalized == "" or normalized == "." then
    return true
  end

  for _, dir in ipairs(ALLOWED_ROOT_DIRS) do
    if normalized == dir or normalized:match("^" .. dir .. "/") then
      return true
    end
  end

  return false
end

local function resolve_package_cwd(file)
  local package_json = vim.fs.find("package.json", { path = file, upward = true })[1]
  if package_json then
    return vim.fs.dirname(package_json)
  end
  return vim.fn.getcwd()
end

local function filter_dir(name, rel_path, root)
  if contains(IGNORED_DIRS, name) then
    return false
  end

  if root and root:match(HENCHMAN_ROOT_PATTERN) then
    return is_henchman_allowed_path(rel_path)
  end

  return true
end

local function is_test_file(file_path)
  if not file_path then
    return false
  end

  if not is_in_allowed_tree(file_path) then
    return false
  end

  if not string.find(file_path, "/tests/") then
    return false
  end

  return string.find(file_path, "%.test%.[jt]sx?$") ~= nil or string.find(file_path, "%.spec%.[jt]sx?$") ~= nil
end

local function is_henchman_repo_path(file_path)
  if not file_path then
    return false
  end

  local git_root = vim.fs.find(".git", { path = file_path, upward = true })[1]
  if not git_root then
    return false
  end

  return vim.fs.dirname(git_root):match(HENCHMAN_ROOT_PATTERN) ~= nil
end

local function escape_test_name_pattern(name)
  return (
    name
      :gsub("%(", "\\(")
      :gsub("%)", "\\)")
      :gsub("%]", "\\]")
      :gsub("%[", "\\[")
      :gsub("%.", "\\.")
      :gsub("%*", "\\*")
      :gsub("%+", "\\+")
      :gsub("%-", "\\-")
      :gsub("%?", "\\?")
      :gsub(" ", "\\s")
      :gsub("%$", "\\$")
      :gsub("%^", "\\^")
      :gsub("%/", "\\/")
  )
end

local function build_nearest_pattern(tree)
  if not tree then
    return nil
  end

  local node = tree:data()
  if not node or (node.type ~= "test" and node.type ~= "namespace") then
    return nil
  end

  local names = {}
  while tree and tree:data().type ~= "file" and tree:data().type ~= "dir" do
    table.insert(names, 1, escape_test_name_pattern(tree:data().name))
    tree = tree:parent()
  end

  if #names == 0 then
    return nil
  end

  return table.concat(names, ".*")
end

local function patch_build_spec(vitest)
  local original_build_spec = vitest.build_spec
  vitest.build_spec = function(args)
    local spec = original_build_spec(args)
    if not spec or not spec.command then
      return spec
    end

    local nearest_pattern = build_nearest_pattern(args and args.tree or nil)

    for i, arg in ipairs(spec.command) do
      if string.find(arg, "^%-%-testNamePattern=") then
        if nearest_pattern and nearest_pattern ~= "" then
          spec.command[i] = "--testNamePattern=" .. nearest_pattern
        else
          spec.command[i] = string.gsub(arg, "%$$", "")
        end
        break
      end
    end

    return spec
  end
end

local function patch_results(vitest)
  local original_results = vitest.results
  vitest.results = function(spec, b, tree)
    local results = original_results(spec, b, tree)
    local node = tree and tree:data() or nil

    if node and (node.type == "test" or node.type == "namespace") then
      local any_passed = false
      local any_failed = false
      local sample_output = nil

      for _, result in pairs(results) do
        if result and result.output and not sample_output then
          sample_output = result.output
        end

        if result and result.status == "passed" then
          any_passed = true
        elseif result and result.status == "failed" then
          any_failed = true
        end
      end

      if any_passed and not any_failed then
        results[node.id] = {
          status = "passed",
          short = (node.name or "nearest") .. ": passed",
          output = sample_output,
        }
      end
    end

    return results
  end
end

local function build_vitest_adapter()
  local vitest = require("neotest-vitest")({
    vitestCommand = "yarn test",
    cwd = resolve_package_cwd,
    filter_dir = filter_dir,
  })

  local default_is_test_file = vitest.is_test_file
  vitest.is_test_file = function(file_path)
    if is_henchman_repo_path(file_path) then
      return is_test_file(file_path)
    end
    return default_is_test_file(file_path)
  end

  patch_build_spec(vitest)
  patch_results(vitest)

  return vitest
end

local function build_opts(vitest)
  return {
    summary = {
      open = "topleft vsplit | vertical resize 50",
    },
    discovery = {
      enabled = true,
    },
    quickfix = {
      enabled = true,
      open = false,
    },
    floating = {
      border = "rounded",
    },
    adapters = {
      vitest,
    },
  }
end

return function()
  local vitest = build_vitest_adapter()
  return build_opts(vitest)
end
