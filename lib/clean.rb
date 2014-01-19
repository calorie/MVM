require "mvm"

class Clean
	def self.run(args,options)
		download_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		Dir.chdir(download_path)
		clean
	end

	def self.clean
		files = Dir.glob("*")
		files.delete(".")
		files.delete("..")
		files.each do |f|
			if File.directory?(f)
				system("rm -r #{f}")
			else
				system("rm #{f}")
			end
		end
	end
end
