# Files
Contains file and directory related narrowing functions for Ido

Introduces the following packages
- `change_dir`
- `find_files`
- `browse`

## Run
```vim
:lua require("ido").pkg.run(PKG_NAME)
```

where `PKG_NAME` is the package you wish to run

## Keybindings
```vim
:lua require("ido").pkg.setup(PKG_NAME, {{bind = KEY_BIND}})
```

where
- `PKG_NAME` is the package name
- `KEY_BIND` is the keybinding in standard vim notation `:h key-notation`
