require 'spec_helper'

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

  Rails3::Assist::Directory::Root.root_directories.each do |name|
    eval %{
      describe '##{name}_dir' do
        it "should return #{name} directory name" do
          CLASS.#{name}_dir.should match /\/\#{name}/
          CLASS.#{name}_dir.should match Regexp.escape(Rails3::Assist::Directory.rails_root)
          @test.#{name}_dir.should match /\/\#{name}/
        end
      end
    } 
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
  
  describe '#self.config_dir_for' do
    it "should return initializers directory name" do
      CLASS.config_dir_for(:initializer).should == File.join(File.dirname(__FILE__), 'config', 'initializers')
    end
  end

  describe '#public_dir_for' do
    it "should return javascripts directory name" do
      @test.public_dir_for(:javascript).should == File.join(File.dirname(__FILE__), 'public', 'javascripts')
    end
  end
end

