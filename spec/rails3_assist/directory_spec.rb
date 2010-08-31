require 'rspec'
require 'rspec/autorun'     

require 'require_all'
require 'rails3_assist/namespaces'
require 'rails3_assist/directory'

CLASS = Rails3::Assist::Directory

class RailsDir
  include CLASS
end

describe Rails3::Assist::Directory do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = File.dirname (__FILE__)
    @test = RailsDir.new
  end

  describe '#rails_dir_for' do
    it "should return mailer directory name" do
      @test.rails_dir_for(:mailer).should == File.join(File.dirname(__FILE__), 'app', 'mailers')
    end
  end

  describe '#rails_dir_for' do
    it "should return app directory name" do
      @test.rails_dir_for(:app).should == File.join(File.dirname(__FILE__), 'app')
    end
  end

  describe '#config_dir_for' do
    it "should return initializers directory name" do
      @test.config_dir_for(:initializer).should == File.join(File.dirname(__FILE__), 'config', 'initializers')
    end
  end

  describe '#public_dir_for' do
    it "should return javascripts directory name" do
      @test.public_dir_for(:javascript).should == File.join(File.dirname(__FILE__), 'public', 'javascripts')
    end
  end
end

