require "nokogiri"
require "fileutils"
require "mvm"

class Use
	def self.run(args,options)
		if options.printdefault
			print_default
			exit
		end

		if options.default[:default]
			version = options.default[:default]
			set_default(version)
			exit
		end

		if options.back
			switch_to_default
			exit
		end

		if options.list
			print_list
			exit
		end
		if args.first.nil?
			puts "Please set verison you switch."
			exit
		end

		unless exists?(args.first)
			puts "Please set already installed version."
			exit
		end
		version = args.first
		switch(version)
	end

	def self.print_default
		default = [MVM::SETTING_DIR,MVM::DEFAULT].join("/")
		open(default) do |f|
			puts f.read.chomp
		end
	end
	def self.set_default(version)
		unless exists?(version)
			puts "#{version} don't installed."
			exit
		end

		default = [MVM::SETTING_DIR,MVM::DEFAULT].join("/")
		open(default,"w") do |f|
			f.write(version+"\n")
		end
	end
	
	def self.switch_to_default
		default = [MVM::SETTING_DIR,MVM::DEFAULT].join("/")
		default_version = nil
		open(default) do |f|
			default_version = f.read.chomp
		end
		if exists?(default_version)
			switch(default_version)
		else
			puts "#{default_version} don't installed."
			exit
		end
	end

	def self.switch(version)
		# remove symbolic link before create 
		if File.symlink?(MVM::SYMBOLIC_LINK)
			FileUtils.rm(MVM::SYMBOLIC_LINK)
		end
		# create symbolic link
		path = open(MVM::INSTALL_PATH) do |f| f.read.chomp end
		if path == ""
			path = MVM::INSTALL_DIR
		end
		system("ln -s #{path}/#{version}/bin #{MVM::SYMBOLIC_LINK}")
	end

	def self.exists?(version)
		is_exist = true
		versions = get_available_versions
		if versions[version].nil?
			is_exist = false
		end

		is_exist
	end

	def self.get_available_versions
		versions = Hash.new
		path = [MVM::SETTING_DIR,MVM::INSTALLED].join("/")
		open(path) do |f|
			while line = f.gets
				versions[line.chomp] = true
			end
		end
		versions
	end

	def self.print_list
		path = [MVM::SETTING_DIR,MVM::INSTALLED].join("/")
		open(path) do |f|
			while line = f.gets
				puts line
			end
		end
	end
end
