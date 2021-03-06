local ido = require("ido")

local search = {}

search.settings = {
   fd_flags = "",
}

-- Escape the path and resolve it
-- @param item The path
-- @return the resolved and escaped path
local function escape(path)
   return vim.fn.shellescape(vim.fn.resolve(path))
end

-- The entry point of the module
-- @return true
function search.main(options)
   options = options or {}

   if not options.cwd then
      options.cwd = vim.fn.expand("%:p")
   end

   if vim.fn.isdirectory(options.cwd) == 0 then
      options.cwd = vim.fn.fnamemodify(options.cwd, ":h")
   end

   options.cwd = options.cwd:gsub("/$", "").."/"

   local item = ido.start{
      items = vim.fn.systemlist(
         "fd -t "..(options.items or "f").." "..

         search.settings.fd_flags..

         " . --base-directory "..escape(options.cwd)),

      prompt = "Files: "
   }

   if #item > 0 then
      vim.cmd((options.cmd or "edit").." "..options.cwd..item)
   end

   return true
end

return search
