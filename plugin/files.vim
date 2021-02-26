if exists("g:ido_pkg_files")
  finish
endif

lua require("ido-pkg/files")
lua require("ido-pkg/browse")
lua require("ido-pkg/cd")

let g:ido_pkg_files = 69
