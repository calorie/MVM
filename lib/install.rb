require "nokogiri"
require "fileutils"
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
		wget(version)
		unzip(version)
		configure(version)
		make(version)
		make_install(version)
		write_installed_version(version)
	end

	def self.wget(version)
		versions = get_available_versions
		url = versions[version].chomp
		if url.nil?
			puts "This version is't exist."
			exit
		end
		download_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		system("wget \"#{url}\" -P #{download_path}")
	end

	def self.unzip
		download_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		path = [download_path,version+".tar.gz"].join("/")
		system("tar zxvf #{path} -C #{download_path}")
	end

	def self.configure(version)
		download_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		path = [download_path,version].join("/")
		install_path = [MVM::INSTALL_DIR,version].join("/")
		system("#{path}/configure --prefix=#{install_path}")
	end

	def self.make(version)
		download_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		path = [download_path,version].join("/")
		system("#{path}/make")
	end

	def self.make_install(version)
		download_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
		path = [download_path,version].join("/")
		system("#{path}/make install")
	end

	def self.write_installed_version(version)
		path = [MVM::SETTING_DIR,INSTALLED].join("/")
		
		open(path,"+w") do |f|
			f.write(version)
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
