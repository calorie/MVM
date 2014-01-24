$:.unshift File.join(File.dirname(__FILE__), '..', 'test')
ENV["HOME"] = "____test" # change home directory for test

require "rspec"
require "mvm"

# rspec file
require "test_init"
#require "test_install"
#require "test_use"
#require "test_uninstall"
#require "test_clean"
#require "test_update"


