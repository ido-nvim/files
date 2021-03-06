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
:lua require("ido").module.run(MODNAME, CWD)
```

where `CWD` is the directory name, and `MODNAME` is the module name.

## Optional arguments for `search`
The search module takes a table of options:

Fields:
- `cwd` Same as earlier

- `cmd` Command to execute on the found item

- `items` The item type to pass to `fd -t`, defaults to `"f"`
