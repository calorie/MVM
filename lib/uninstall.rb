require 'mvm'

class Uninstall
  def self.run(args,options)
    if options.list
      print_list
      exit
    end
    if args.first.nil?
      puts 'Please set verison you uninstall.'
      exit
    end

    version = args.first

    unless exists?(version)
      puts 'The version you specified don't installed.'
      exit
    end

    uninstall(version)
    remove_installed_version(version)
  end

  def self.uninstall(version)
    install_path = open(MVM::INSTALL_PATH) do |f| f.read.chomp end
    if install_path == ''
      install_path = File.join(MVM::INSTALL_DIR, version)
    else
      install_path = File.join(install_path, version)
    end
    system("rm -r #{install_path}")
  end

  def self.remove_installed_version(version)
    path = File.join(MVM::SETTING_DIR, MVM::INSTALLED)

    versions = Array.new
    open(path, 'r') do |f|
      while line = f.gets
        versions << line.chomp
      end
    end

    versions.delete(version)

    open(path, 'w') do |f|
      versions.each do |e|
        f.write(e + "\n")
      end
    end

  end

  def self.exists?(version)
    is_exist = false
    path = File.join(MVM::SETTING_DIR, MVM::INSTALLED)
    open(path) do |f|
      while line = f.gets
        if version == line.chomp
          is_exist = true
          break
        end
      end
    end
    is_exist
  end

  def self.print_list
    path = File.join(MVM::SETTING_DIR, MVM::INSTALLED)
    open(path) do |f|
      while line = f.gets
        puts line
      end
    end
  end
end
