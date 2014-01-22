require "fileutils"
require "mvm"

class Init
  def self.run(args,options)
    dir_path = [MVM::SETTING_DIR,MVM::DOWNLOAD_DIR].join("/")
    FileUtils.mkdir_p(dir_path)
    FileUtils.mkdir_p(MVM::INSTALL_DIR)

    versions_path  = [MVM::SETTING_DIR,MVM::VERSIONS].join("/")
    installed_path = [MVM::SETTING_DIR,MVM::INSTALLED].join("/")
    default_path = [MVM::SETTING_DIR,MVM::DEFAULT].join("/")
    install_dir  = MVM::INSTALL_DIR
    install_path = MVM::INSTALL_PATH

    FileUtils.touch(versions_path)
    FileUtils.touch(installed_path)
    FileUtils.touch(default_path)
    FileUtils.touch(install_dir)
    FileUtils.touch(install_path)

    if options.installpath
      path = options.installpath
      open(MVM::INSTALL_PATH,"w") do |f|
        f.write(path+"\n")
      end
    end

    puts "Please input the following command."
    puts "echo 'export PATH=#{MVM::SYMBOLIC_LINK}:$PATH' >> /etc/profile"
  end
end
