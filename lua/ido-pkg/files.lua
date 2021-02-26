local pkg = require("ido").pkg

-- Fuzzy find files
local function find_files()
   local file = pkg.start({
      items = vim.fn.systemlist("fd -t f -H . $HOME"),
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
})
