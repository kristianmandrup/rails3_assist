require 'rspec'
require 'rspec/autorun'     

require 'require_all'
require 'rails3_assist/namespaces'
require 'rails3_assist/directory'

CLASS = Rails3::Assist::Directory::App

class AppDir
  include CLASS
end

describe Rails3::Assist::Directory::App do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = File.dirname (__FILE__)
  end

  describe '#self.app_directories' do
    it "should return symbols list of Rails 3 app directories" do
      CLASS.app_directories.should include :controllers, :mailers, :helpers, :views, :models, :permits
    end
  end

  describe '#app_directories' do
    it "should return symbols list of Rails 3 app directories" do
      AppDir.new.app_directories.should include :controllers, :mailers, :helpers, :views, :models, :permits
    end
  end


  describe '#self.app_dir' do
    it "should the current Rails 3 ap dir when Rails root is set" do
      CLASS.app_dir.should == File.join(File.dirname(__FILE__), 'app')
    end
  end

  describe '#app_dir' do
    it "should the current Rails 3 ap dir when Rails root is set" do
      AppDir.new.app_dir.should == File.join(File.dirname(__FILE__), 'app')
    end
  end
end

