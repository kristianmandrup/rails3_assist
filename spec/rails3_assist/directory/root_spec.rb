require 'spec_helper'

CLASS = Rails3::Assist::Directory::Root

class RootDir
  include CLASS
end

describe Rails3::Assist::Directory::Root do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = File.dirname (__FILE__)
  end

  describe '#self.root_directories' do
    it "should return symbols list of Rails 3 root directories" do
      CLASS.root_directories.should include :app, :config, :db
    end
  end

  describe '#root_directories' do
    it "should return symbols list of Rails 3 root directories" do
      RootDir.new.root_directories.should include :app, :config, :db
    end
  end


  describe '#self.root_dir' do
    it "should the current Rails 3 ap dir when Rails root is set" do
      CLASS.root_dir.should == File.dirname(__FILE__)
    end
  end

  describe '#root_dir' do
    it "should the current Rails 3 ap dir when Rails root is set" do
      RootDir.new.root_dir.should == File.dirname(__FILE__)
    end
  end
end

