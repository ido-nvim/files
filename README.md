# Files
Contains file and directory related narrowing functions for Ido.

Introduces the following modules:
- `navigate` Change the directory of Vim
- `search` Search for files/directories
- `browse` File browser

## Quick setup
```lua
require("ido").setup{
   packages = {
      files = {}
   }
}
```

## Run
```vim
:lua require("ido").module.run(MODNAME)
```

where `MODNAME` is one of the three modules shown above
