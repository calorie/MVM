require "nokogiri"
require "fileutils"
require "mvm"

class Switch
	def self.run(args,options)
		if options.list
			print_list
			exit
		end
		if args.first.nil?
			puts "Please set verison you switch."
			exit
		end
		machines = nil
		if options.machinefile
			machines = read_machine_file(options.machine)
			if machines.nil?
				puts "Reading machinefile failed."
				exit
			end
		end

		unless exists?(args.first)
			puts "Please set already installed version."
			exit
		end
		version = args.first
		switch(version)
		remote_switch(version,machines)
	end

	def self.remote_switch(version,machines)
		#TODO ssh remote command
	end
	
	def self.switch(version)
		# remove symbolic link before create 
		if File.symlink?(MVM::SYMBOLIC_LINK)
			FileUtils.rm(MVM::SYMBOLIC_LINK)
		end
		# create symbolic link
		system("ln -s /opt/mpich/#{version}/bin #{MVM::SYMBOLIC_LINK}")
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