local advice = require("ido.core.advice")
local ido = require("ido")
local main = require("ido.core.main")
local ui = require("ido.core.ui")

local pkg = ido.pkg

--- Escape the file or directory path and resolve it
-- @param item The file/directory path
-- @return the resolved and shell-escaped item path
local function escape(item)
   return vim.fn.shellescape(vim.fn.resolve(item))
end

--- Get list of files and directories
-- @param directory The directory
-- @return output of ls with some opts
local function list(directory)
   return vim.fn.systemlist("ls -AF --group-directories-first "..escape(directory))
end

-- File browser
local function browse()

   -- Do not exit on accept, instead do this
   advice.set("exit_on_accept_selected", "overwrite", function ()
      local vars = ido.sandbox.vars
      local opts = ido.sandbox.opts

      local selected = ""

      -- Check if something matched or not
      if #vars.results > 0 then
         selected = vars.results[vars.selected][1]
      else

         -- The query is the thing we need to work with
         selected = vars.before_cursor..vars.after_cursor
      end

      -- Check if it is a directory
      if selected:sub(-1, -1) == "/" then

         -- Change to the directory
         opts.prompt = opts.prompt..selected
         vars.items = list(opts.prompt:sub(9, -1))

         -- Clear the query
         vars.before_cursor = ""
         vars.after_cursor = ""

         -- Asynchronously fetch the items
         main.async(main.get_results)
      else

         -- It's a file, edit it
         main.exit()
         vim.cmd("edit "..opts.prompt:sub(9, -1).. -- The directory
            selected) -- The file

      end
   end, false)

   -- Change the action which happens when we try to delete something
   -- before the cursor but there is nothing to delete
   advice.set("delete_backward_impossible", "overwrite", function ()
      local vars = ido.sandbox.vars
      local opts = ido.sandbox.opts

      -- Check if the text after the cursor is empty
      if #vars.after_cursor == 0 then
         -- It is, go up a directory

         -- Can't go up if the directory is /
         if opts.prompt == "Browse: /" then
            return true
         end

         opts.prompt = opts.prompt:gsub("[^/]*/$", "")
         vars.items = list(opts.prompt:sub(9, -1))
         main.async(main.get_results)
      end

   end, false)

   -- Change directory on pressing '/'
   advice.set("insert_string", "after", function ()
      local vars = ido.sandbox.vars
      local opts = ido.sandbox.opts

      if vars.before_cursor:sub(-1, -1) == "/" and
         os.execute("test -d "..opts.prompt:sub(9, -1)..vars.before_cursor) == 0 then

         -- Change to the directory
         opts.prompt = opts.prompt..vars.before_cursor..vars.after_cursor
         vars.items = list(opts.prompt:sub(9, -1))

         -- Clear the query
         vars.before_cursor = ""
         vars.after_cursor = ""

         -- Asynchronously fetch the items
         main.async(main.get_results)
      end
   end)

   -- Get the directory of the current buffer
   -- If the current buffer is a file, get its parent directory
   -- If the current buffer is not a file, get the working directory
   local directory = vim.fn.expand("%:p")

   if #directory == 0 then
      directory = vim.loop.cwd()
   end

   if vim.fn.isdirectory(directory) == 0 then
      directory = vim.fn.fnamemodify(directory, ":h")
   end

   directory = directory:gsub("/$", "").."/"

   pkg.start({
      items = list(directory),
      prompt = "Browse: "..directory,
   })

   return true
end

-- Setup the package
pkg.new("browse", {
   main = browse,

   disable = {
      "prompt"
   }
})
