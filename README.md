# Files
Contains file and directory related narrowing functions for Ido.

Introduces the following modules:
- `navigate` Change the directory of Vim
- `search` Search for files/directories
- `browse` File browser

## Quick setup
- Install the plugin:

| Manager | Command |
| ------- | ------- |
| [`plug`](https://github.com/junegunn/vim-plug) | `Plug 'ido-nvim/files'` |
| [`vundle`](https://github.com/VundleVim/Vundle.vim) | `Plugin 'ido-nvim/files'` |
| [`dein`](https://github.com/Shougo/dein.vim) | `call dein#add('ido-nvim/files')` |
| [`minpac`](https://github.com/k-takata/minpac) | `call minpac#add('ido-nvim/files')` |
| [`packer`](https://github.com/wbthomason/packer.nvim) | `use 'ido-nvim/files'` |

Setup the package:

```lua
require("ido").setup{
   packages = {
      files = {}
   }
}
```

## Run
```vim
:lua require("ido").module.run("files/MODNAME")
```

where `MODNAME` is one of the three modules shown above

## Settings
The settings in this package

| Browse settings | Description | Default value |
| -------------- | ----------- | ------------- |
| `ls_flags` | The flags passed to `ls` | `"-AF --group-directories-first"` |
| `prompt_header` | The header before the prompt | `"Browse: "` |

| Search settings | Description | Default value |
| -------------- | ----------- | ------------- |
| `fd_flags` | The flags passed to `fd` | `""` |

## Optional arguments for `browse` and `navigate`
```vim
:lua require("ido").module.run("files/MODNAME", CWD)
```

where `CWD` is the directory name, and `MODNAME` is the module name.

## Optional arguments for `search`
The search module takes a table of options:

Fields:
- `cwd` Same as earlier

- `cmd` Command to execute on the found item

- `items` The item type to pass to `fd -t`, defaults to `"f"`

## Example configuration
The following snippet is in lua, ***not*** vimL.

```lua
require("ido").setup{
   packages = {

      -- Configure the `files` package
      files = {

         -- The `browse` module configuration
         browse = {

            -- The settings, see above for explanation
            settings = {
               ls_flags = "-AF"
            },

            -- The binding, like doing `noremap` in VimL
            binding = {
               key = "<Leader>."
            }
         },

         -- The `search` module configuration
         search = {

            -- The ido options
            options = {
               prompt = "Files> "
            },
         }
      }
   }
}
```
