require "mvm"

class Export
	def self.run(args,options)
		if options.list
			print_list
			exit
		end

		machines = nil
		if options.machine
			machines = read_machine_file(options.machine)
			if machines.nil?
				puts "Reading machinefile failed."
				exit
			end
		else
			puts "Please set --machinefile option."
			exit
		end

		if args.first.nil?
			puts "Please set already installed verison."
			exit
		end

		version = args.first

		export(version,machines)
	end

	def self.export
		p "under construction..."
		#TODO file check at other machines
		#TODO scp binary
		#TODO file check at other machines
	end

	def self.read_machine_file(filename)
		machines = Array.new
		open(filename) do |f|
			while line = f.gets
				machine << line.chomp
			end
		end
		machines
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
