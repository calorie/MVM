require "mvm"

class Export
	def self.run(args,options)
		p "under construction..."
		exit
		if options.list
			print_list
			exit
		end
		if args.first.nil?
			puts "Please set verison you install."
			exit
		end
		version = args.first
		download_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		write_installed_version(version)
	end

	def self.write_installed_version(version)
		path = [MVM::SETTING_DIR,MVM::INSTALLED].join("/")
		
		open(path,"a") do |f|
			f.write(version+"\n")
		end
	end

	def self.get_available_versions
		versions = Hash.new
		path = [MVM::SETTING_DIR,MVM::VERSIONS].join("/")
		open(path) do |f|
			while line = f.gets
				key = line.split(":").first[0..-8]
				value = line.split(":")[1..-1].join(":")
				versions[key] = value
			end
		end
		versions
	end

	def self.print_list
		path = [MVM::SETTING_DIR,MVM::VERSIONS].join("/")
		open(path) do |f|
			while line = f.gets
				puts line.split(":").first[0..-8]
			end
		end
	end
end
