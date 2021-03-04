local pkg = require("ido").pkg
local DEFAULT_COMMAND = "fd -t f -H . $HOME"

-- Fuzzy find files
local function find_files(pkg_opts)
   local file = pkg.start({
      items = vim.fn.systemlist(pkg_opts.command),
      prompt = "Files: ",
   })

   if #file > 0 then
      vim.cmd("edit "..file)
   end

   return ""
end

-- Setup the package
pkg.new("find_files", {
   main = find_files,
   pkg_opts = {
      command = DEFAULT_COMMAND
   }
})
