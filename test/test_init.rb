#$:.unshift File.join(File.dirname(__FILE__), '..', 'test')
#ENV["HOME"] = "____test" # change home directory for test

require "rspec"
require "mvm"
require "init"

describe "mvm commands" do
  describe "when mvm init" do
    context "with no options" do
      before do
        `bundle exec mvm init`
      end

      # TODO file and directory check
      it "make needed directories and files" do
        File.exists?(MVM::SETTING_DIR).should be_true
      end

      after do
        `rm -r #{ENV["HOME"]}`
      end
    end

    context "with --installpath" do
      before do
        `bundle exec mvm init --installpath=#{File.join(ENV["HOME"],"test")}`
      end

      # TODO file and directory check
      it "make needed directories and files" do
        File.exist?(MVM::SETTING_DIR).should be_true
      end

      after do
        `rm -r #{ENV["HOME"]}`
      end
    end

  end
end


