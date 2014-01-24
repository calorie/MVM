require "fileutils"
require "mvm"

class Init
  def self.run(args,options)
    dir_path = File.join(MVM::SETTING_DIR, MVM::DOWNLOAD_DIR)
    FileUtils.mkdir_p(dir_path)
    FileUtils.mkdir_p(MVM::INSTALL_DIR)

    versions_path  = File.join(MVM::SETTING_DIR, MVM::VERSIONS)
    installed_path = File.join(MVM::SETTING_DIR, MVM::INSTALLED)
    default_path   = File.join(MVM::SETTING_DIR, MVM::DEFAULT)
    install_dir    = MVM::INSTALL_DIR
    install_path   = MVM::INSTALL_PATH

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
    puts "--- if all user use mvm ---"
    puts "echo 'export PATH=#{MVM::SYMBOLIC_LINK}:$PATH' >> /etc/profile"
    puts "--- if you use mvm ---"
    puts "echo 'export PATH=#{MVM::SYMBOLIC_LINK}:$PATH' >> ~/.bashrc"
  end
end
