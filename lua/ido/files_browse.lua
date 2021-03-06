local ido = require("ido")
local main = ido.main
local event = ido.event
local advice = ido.advice
local config = ido.config
local result = ido.result

local browse = {}

browse.settings = {
   ls_flags = "-AF --group-directories-first",
   prompt_header = "Browse: "
}

browse.disabled = {
   prompt = true
}

-- Escape the path and resolve it
-- @param item The path
-- @return the resolved and escaped path
local function escape(path)
   return vim.fn.shellescape(vim.fn.resolve(path))
end

-- Like `pwd`
-- @return the current browser directory
local function pwd()
   return main.sandbox.options.prompt:sub(browse.settings.prompt_header:len() + 1):gsub("/$", "").."/"
end

-- Like `ls`
-- @param directory The directory
-- @return output of ls with some opts
local function ls(directory)
   return vim.fn.systemlist("ls "..browse.settings.ls_flags.." "..escape(directory or pwd()))
end

-- Like `cd`
-- @param directory The directory
-- @return nil if it is an invalid directory, else true
local function cd(directory)
   local directory = vim.fn.resolve(pwd()..directory)

   if vim.fn.isdirectory(directory) == 0 then
      return nil
   end

   local variables = main.sandbox.variables
   local options = main.sandbox.options

   options.prompt = browse.settings.prompt_header..directory:gsub("/$", "").."/"

   variables.items = ls()
   variables.before = ""
   variables.after = ""

   event.async(result.fetch)
   return true
end

local function edit(file)
   vim.cmd("edit "..file)
end

local function open(path)
   if path:sub(-1) == "/" then
      cd(path)
   else
      event.stop()
      edit(pwd()..path)
   end
end

function browse.main(cwd)

   advice.add{
      name = "browse",
      target = "selected@accept:stop_event_loop",
      action = function ()

         local variables = main.sandbox.variables

         local selected = ""

         if #variables.results > 0 then
            selected = variables.results[variables.selected][1]
         else
            selected = variables.before..variables.after
         end

         open(selected)
      end,
      temporary = 1
   }

   advice.add{
      name = "browse",
      target = "insert@main:append_string",
      action = function ()
         if main.sandbox.variables.before:sub(-1) == "/" then
            cd(variables.before)
         end
      end,
      temporary = 1,
      hook = "after"
   }

   advice.add{
      name = "parent",
      target = "execute@delete:backward_impossible",
      action = function ()
         if #main.sandbox.variables.after == 0 then
            cd("..")
         end
      end,
      temporary = 1,
      hook = "overwrite"
   }

   if not cwd then
      cwd = vim.fn.expand("%:p")

      if vim.fn.isdirectory(cwd) == 0 then
         cwd = vim.fn.fnamemodify(cwd, ":h")
      end

      cwd = cwd:gsub("/$", "").."/"
   end

   ido.start{
      items = ls(cwd),
      prompt = browse.settings.prompt_header..cwd
   }
end

return browse
