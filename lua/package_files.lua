local package = require("ido.package")

package.new{
   name = "files",

   modules = {
      "browse",
      "search",
      "navigate",
   }
}
