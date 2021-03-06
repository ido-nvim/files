local ido = require("ido")
local search = require("ido.files_search")

local navigate = {}

-- The entry point of the module
-- @return true
function navigate.main(cwd)
   search.main{
      items = "d",
      cwd = cwd,
      cmd = "cd"
   }

   return true
end

return navigate
