require "mvm/version"

module MVM
	# Only set path.
	SETTING_DIR   = File.join(ENV["HOME"], ".mvm")
	VERSIONS      = "versions"
	INSTALLED     = "installed"
	DEFAULT       = "default"
	DOWNLOAD_DIR  = "download"
  INSTALL_PATH  = File.join(SETTING_DIR, 'install_path')
  INSTALL_DIR   = File.join(SETTING_DIR, 'bins')
  SYMBOLIC_LINK = File.join(INSTALL_DIR, 'bin')
end
