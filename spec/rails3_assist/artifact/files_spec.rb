require 'spec_helper'

CLASS = Rails3::Assist::Artifact::Files

class ArtDir
  extend Rails3::Assist::UseMacro
  use_helper :files  
end

describe Rails3::Assist::Artifact::Files do
  use_helper :directory

  before do
    Rails3::Assist::Directory.rails_root = fixtures_dir
    @test = ArtDir.new
  end

  describe '#model_files' do 
    it "should return :model files" do    
      @test.model_files.file_names.should include 'user.rb'
    end
  end

  describe '#mailer_files' do 
    it "should return :mailer files" do
      puts @test.mailer_files.file_names.should include 'user_mailer.rb'
    end
  end

  describe '#observer_files' do 
    it "should return :observer files" do
      puts @test.observer_files.file_names.should include 'user_observer.rb'
    end
  end

  describe '#permit_files' do 
    it "should return :permit files" do
      puts @test.permit_files.file_names.should include 'user_permit.rb'
    end
  end
   
  describe '#helper_files' do 
    it "should return :helper files" do
      @test.helper_files.file_names.should include 'users_helper.rb'
    end
  end
  
  describe '#controller_files' do 
    it "should return :controller files" do
      @test.controller_files.file_names.should include 'users_controller.rb'
    end
  end
  
  describe '#view_files' do 
    it "should return :view files" do
      @test.view_files(:user).file_names.should include 'show.html.erb'
    end
  end 

  describe '#erb_view_files' do 
    it "should return erb :view files" do
      @test.erb_view_files(:user).file_names.should include 'show.html.erb'
    end
  end 
end
