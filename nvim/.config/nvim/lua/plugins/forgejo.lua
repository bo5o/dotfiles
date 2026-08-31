-- :GBrowse support for self-hosted Forgejo/Gitea instances.
--
-- Fugitive only knows GitHub (via vim-rhubarb); other forges plug in through
-- g:fugitive_browse_handlers, where each handler returns a URL for the remotes it
-- recognizes and "" for the rest. The spec below is another fragment of the
-- vim-fugitive spec in git.lua, which lazy merges with it.

-- Split a git remote URL into hostname (no port) and repo path.
-- Handles scp-style (git@host:owner/repo.git) and scheme://host/owner/repo.git.
local function split_remote(remote)
  local rest = remote:match("^%a[%w+.%-]*://(.*)$")
  local host, path
  if rest then
    host, path = rest:gsub("^[^/@]*@", ""):match("^([^/]+)/(.*)$")
  else
    host, path = remote:match("^[^/@]*@?([^/:]+):(.*)$")
  end
  if not host then
    return nil, nil
  end
  return host:gsub(":%d+$", ""), (path:gsub("%.git/?$", ""):gsub("/+$", ""))
end

-- Web root of a repo if its remote points at a configured Forgejo domain.
-- Domains are read from git config, so private hosts stay out of these dotfiles:
--   git config --global --add fugitive.forgejoDomain git.example.com
-- A value may be a bare host or a full URL, the latter for instances that are not
-- plain https on the default port, or that live under a subpath.
local function forgejo_root(remote, git_dir)
  local host, path = split_remote(remote)
  if not host then
    return nil
  end
  local domains = vim.fn.FugitiveConfigGetAll("fugitive.forgejoDomain", git_dir)
  for _, domain in ipairs(domains) do
    local base = domain:match("^%a[%w+.%-]*://") and domain or ("https://" .. domain)
    local root, base_host, prefix = base:match("^(%a[%w+.%-]*://([^/]+))(.*)$")
    prefix = (prefix or ""):gsub("^/", ""):gsub("/+$", "")
    if base_host and base_host:gsub(":%d+$", "") == host then
      -- SSH remotes lack the subpath an instance may be mounted under
      if prefix ~= "" and not vim.startswith(path, prefix .. "/") then
        path = prefix .. "/" .. path
      end
      return root .. "/" .. path
    end
  end
end

-- Extensions Forgejo renders instead of showing source, so a line anchor only means
-- something with ?display=source. Its built-in renderers (modules/markup/*/, plus
-- svg, which gets the same toggle) and the extensions of the optional external ones.
local rendered_exts = {
  md = true,
  markdown = true,
  mdown = true,
  mkd = true,
  livemd = true,
  org = true,
  csv = true,
  tsv = true,
  cast = true,
  ["sh-session"] = true,
  svg = true,
  rst = true,
  adoc = true,
  asciidoc = true,
}

-- Forgejo needs the kind of ref spelled out in the URL (/src/{branch,tag,commit}/),
-- while fugitive hands us either a sha or a ref name.
local function ref_type(commit, git_dir)
  if commit:match("^%x%x%x%x%x%x%x+$") then
    return "commit"
  end
  local name = vim.fn["fugitive#UrlDecode"](commit)
  for _, ref in ipairs({ { "branch", "refs/heads/" }, { "tag", "refs/tags/" } }) do
    local result = vim.fn.FugitiveExecute(
      { "rev-parse", "--verify", "--quiet", ref[2] .. name },
      git_dir
    )
    if result.exit_status == 0 then
      return ref[1]
    end
  end
  return "commit"
end

local function forgejo_url(opts)
  local root = forgejo_root(opts.remote or "", opts.git_dir)
  if not root then
    return ""
  end

  local path = (opts.path or ""):gsub("^/", "")
  local ref = path:match("^%.git/(refs/.*)$")
  if ref then
    local branch = ref:match("^refs/heads/(.+)$")
      or ref:match("^refs/remotes/[^/]+/(.+)$")
    if branch then
      return root .. "/commits/branch/" .. branch
    end
    local tag = ref:match("^refs/tags/(.+)$")
    if tag then
      return root .. "/src/tag/" .. tag
    end
  end
  if path:match("^%.git") then
    return root
  end

  local commit = (opts.commit or ""):gsub("#", "%%23")
  local line1, line2 = opts.line1 or 0, opts.line2 or 0
  local src = root .. "/src/" .. ref_type(commit, opts.git_dir) .. "/" .. commit

  if opts.type == "tree" or path:sub(-1) == "/" then
    return (src .. "/" .. path):gsub("/$", "")
  elseif opts.type == "blob" or path ~= "" then
    local url = src .. "/" .. path
    if line1 > 0 and rendered_exts[vim.fn.fnamemodify(path, ":e"):lower()] then
      url = url .. "?display=source"
    end
    if line1 > 0 and line2 > line1 then
      url = url .. "#L" .. line1 .. "-L" .. line2
    elseif line1 > 0 then
      url = url .. "#L" .. line1
    end
    return url
  end

  return root .. "/commit/" .. commit
end

return {
  {
    "tpope/vim-fugitive",
    init = function()
      -- Handlers have to be registered before :GBrowse runs
      local handlers = vim.g.fugitive_browse_handlers or {}
      table.insert(handlers, forgejo_url)
      vim.g.fugitive_browse_handlers = handlers
    end,
  },
}
