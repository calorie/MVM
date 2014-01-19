require "fileutils"
require "mvm"

class Init
	def self.run(args,options)
		dir_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		FileUtils.mkdir_p(dir_path)

		versions_path = [MVM::SETTING_DIR,MVM::VERSIONS].join("/")
		installed_path = [MVM::SETTING_DIR,MVM::INSTALLED].join("/")

		FileUtils.touch(versions_path)
		FileUtils.touch(installed_path)
		
		system("echo 'export PATH=#{MVM::INSTALL_DIR}/bin:$PATH' >> ~/.bash_profile ")
	end
end
