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

    versions = get_available_versions
    unless versions.include?(version)
      puts "Please set one of available versions."
      exit
    end

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
    path = [download_path,version+".tar.gz"].join("/")
    unless File.exists?(path)
      system("wget \"#{url}\" -P #{download_path}")
    end
  end

  def self.unzip(version,download_path)
    path = [download_path,version+".tar.gz"].join("/")
    system("tar zxvf #{path} -C #{download_path}")
  end

  def self.configure(version,download_path)
    path = [download_path,version].join("/")
    install_path = open(MVM::INSTALL_PATH) do |f| f.read.chomp end
    if install_path == ""
      install_path = [MVM::INSTALL_DIR,version].join("/") 
    else
      install_path = [install_path,version].join("/")
    end

    system("#{path}/configure --prefix=#{install_path}")
    unless File.exists?("Makefile")
      puts "configuring failed."
      exit
    end
  end

  def self.make
    system("make")
  end

  def self.make_install
    system("make install")
  end

  def self.write_installed_version(version)
    install_path = open(MVM::INSTALL_PATH) do |f| f.read.chomp end
    if install_path == ""
      install_path = [MVM::INSTALL_DIR,version].join("/") 
    else
      install_path = [install_path,version].join("/")
    end

    unless File.exists?(install_path)
      puts "Install failed."
      exit
    end

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
