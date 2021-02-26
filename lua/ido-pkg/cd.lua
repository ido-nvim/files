local pkg = require("ido").pkg

-- Change the current directory
local function change_dir()
   local dir = pkg.start({
      items = vim.fn.systemlist("fd -t d -H . $HOME"),
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
