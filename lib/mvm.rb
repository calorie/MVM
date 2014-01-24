require "mvm/version"

module MVM
  # Only set path.
  SETTING_DIR   = File.expand_path("~/.mvm")
  VERSIONS      = "versions"
  INSTALLED     = "installed"
  DEFAULT       = "default"
  DOWNLOAD_DIR  = "download"
  INSTALL_PATH  = [SETTING_DIR,"install_path"].join("/")
  INSTALL_DIR   = [SETTING_DIR,"bins"].join("/")
  SYMBOLIC_LINK = [INSTALL_DIR,"bin"].join("/")
end
