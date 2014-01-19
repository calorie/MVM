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

		unless exists?(args.first)
			puts "Please set already installed version."
			exit
		end
		version = args.first
		switch(version)
	end
	
	def self.switch(version)
		# remove symbolic link before create 
		if File.exists?(MVM::SYMBOLIC_LINK)
			FileUtils.rm(MVM::SYMBOLIC_LINK)
		end
		# create symbolic link
		"ln -s /opt/mpich/#{version}/bin #{MVM::SYMBOLIC_LINK}"
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
				key = line.split(":").first[0..-8]
				value = line.split(":")[1..-1].join(":")
				versions[key] = value
			end
		end
		versions
	end

	def self.print_list
		path = [MVM::SETTING_DIR,MVM::INSTALLED].join("/")
		open(path) do |f|
			while line = f.gets
				puts line.split(":").first[0..-8]
			end
		end
	end
end
