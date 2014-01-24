require "spec_helper"
require "init"

describe "mvm commands" do
  describe "when mvm init" do
    context "with no options" do
      before do
        `bundle exec mvm init`
      end

      # TODO file and directory check
      it "make needed directories and files" do
        expect(File.exists?(MVM::SETTING_DIR)).to be_true
      end

      after do
        `rm -r #{ENV['MVM_HOME']}`
      end
    end

    context "with --installpath" do
      before do
        `bundle exec mvm init --installpath=#{File.join(ENV['MVM_HOME'],"test")}`
      end

      # TODO file and directory check
      it "make needed directories and files" do
        expect(File.exist?(MVM::SETTING_DIR)).to be_true
      end

      after do
        `rm -r #{ENV['MVM_HOME']}`
      end
    end

  end
end
