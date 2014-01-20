require "mvm/version"

module MVM
	# Only set path.
	# Don't write logic.
	SETTING_DIR   = File.expand_path("~/.mvm")
	VERSIONS      = "versions"
	INSTALLED     = "installed"
	DEFAULT       = "default"
	DOWNLOAD_DIR  = "download"
	INSTALL_DIR   = [SETTING_DIR,"bins"]
	SYMBOLIC_LINK = [INSTALL_DIR,"bin"].join("/")
end
