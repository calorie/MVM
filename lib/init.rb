require "fileutils"
require "mvm"

class Init
	def self.run(args,options)
		dir_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		FileUtils.mkdir_p(dir_path)

		versions_path = [MVM::SETTING_DIR,MVM::VERSIONS].join("/")
		installed_path = [MVM::SETTING_DIR,MVM::INSTALLED].join("/")
		default_path = [MVM::SETTING_DIR,MVM::DEFAULT].join("/")

		FileUtils.touch(versions_path)
		FileUtils.touch(installed_path)
		FileUtils.touch(default_path)

		puts "Please input the following command."
		puts "echo 'export PATH=#{SYMBOLIC_LINK}:$PATH' >> /etc/profile"
	end
end
