local pkg = require("ido").pkg
local DEFAULT_COMMAND  = "fd -t d -H . $HOME"

-- Change the current directory
local function change_dir(pkg_opts)
   local dir = pkg.start({
      items = vim.fn.systemlist(pkg_opts.command),
      prompt = "Dirs: ",
   })

   if #dir > 0 then
      vim.cmd("cd "..dir)
   end

   return ""
end

-- Setup a package
pkg.new("change_dir", {
   main = change_dir,
})
