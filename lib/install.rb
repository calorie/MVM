require "mvm"

class Install
	def self.run(args,options)
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
		wget(version,download_path)
		unzip(version,download_path)
		working_dir = [download_path,version].join("/")
		Dir.chdir(working_dir)
		configure(version,download_path)
		make
		make_install
		write_installed_version(version)
	end

	def self.wget(version,download_path)
		versions = get_available_versions
		url = versions[version].chomp
		if url.nil?
			puts "This version is't exist."
			exit
		end
		system("wget \"#{url}\" -P #{download_path}")
	end

	def self.unzip(version,download_path)
		path = [download_path,version+".tar.gz"].join("/")
		system("tar zxvf #{path} -C #{download_path}")
	end

	def self.configure(version,download_path)
		path = [download_path,version].join("/")
		install_path = [MVM::INSTALL_DIR,version].join("/")
		system("#{path}/configure --prefix=#{install_path}")
	end

	def self.make
		system("make")
	end

	def self.make_install
		system("make install")
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
