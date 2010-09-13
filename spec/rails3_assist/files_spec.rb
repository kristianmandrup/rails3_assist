require 'spec_helper'

CLASS = Rails3::Assist::Files

class AppDir
  extend Rails3::Assist::UseMacro
  use_helper :files
end

describe Rails3::Assist::Files do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = fixtures_dir
  end

  describe '#rails_app_files' do
    it "should return all :app files using default pattern" do
      AppDir.new.rails_app_files(:model)
    end
  end

  describe '#all_files' do
    it "should return all_files in the app" do    
      CLASS.all_files.file_names.should include('user.rb', 'users_helper.rb')
    end
  
    it "should return all_files in the app matching expr" do
      CLASS.all_files(/user/).file_names.should include('user.rb', 'users_helper.rb')
      CLASS.all_files('user').file_names.should include('user.rb', 'users_helper.rb')
    end
      
    it "should return all_files in the app matching expr, in a block" do    
      CLASS.all_files('user') do |files|
        files.file_names.should include('user.rb', 'users_helper.rb')
      end
    end
  end
  
  describe '#app_files' do
    it "should return app_files in the app" do    
      CLASS.all_files.file_names.should include('user.rb', 'users_helper.rb')
    end
  
    it "should return app_files in the app matching expr" do    
      CLASS.all_files('user').file_names.should include('user.rb', 'users_helper.rb')
    end
  
    it "should return app_files in the app matching expr, in a block" do    
      CLASS.app_files('user') do |files|
        files.file_names.should include('user.rb', 'users_helper.rb')
      end
    end
  end
  
  describe '#files_from' do
    it "should return files from model dir" do    
      CLASS.files_from(:model).file_names.should include 'user.rb'
    end
  
    it "should return files from model, mailer and controller dirs" do    
      CLASS.files_from(:model, :mailer, :controller).file_names.should include('user.rb', 'user_mailer.rb', 'users_controller.rb')
    end
  
    it "should return block with files from model, mailer and controller dirs" do    
      CLASS.files_from(:model, :mailer, :controller) do |files|
        files.file_names.should include('user.rb', 'user_mailer.rb', 'users_controller.rb')
      end
    end
  end
  
  describe '#initializer_files' do
    it "should return files for initializer directory" do    
      CLASS.initializer_files.file_names.should include('mime_types.rb', 'secret_token.rb')
    end
  
    it "should return files for initializer directory" do    
      files = CLASS.initializer_files('mime').file_names
      files.should include('mime_types.rb')
      files.should_not include('secret_token.rb')
    end
  
    it "should return files for initializer directory, in a block" do    
      CLASS.initializer_files('mime') do |files|
        files.file_names.should include('mime_types.rb')
        files.file_names.should_not include('secret_token.rb')  
      end      
    end
  end
  
  
  describe '#locale_files' do
    it "should return files for locale directory" do    
      CLASS.locale_files.file_names.should include('en.yml')
    end
  
    it "should return files for initializer directory" do    
      files = CLASS.initializer_files('mime').file_names
      files.should include('mime_types.rb')
      files.should_not include('secret_token.rb')
    end
    
    it "should return files for initializer directory, in a block" do    
      CLASS.initializer_files('mime') do |files|
        files.file_names.should include('mime_types.rb')
        files.file_names.should_not include('secret_token.rb')  
      end      
    end
  end
  
  describe '#css_files' do
    it "should return files for css directory" do    
      CLASS.css_files.file_names.should include('scaffold.css')
    end
  
    it "should return files for initializer directory" do    
      files = CLASS.initializer_files('mime').file_names
      files.should include('mime_types.rb')
      files.should_not include('secret_token.rb')
    end
    
    it "should return files for initializer directory, in a block" do    
      CLASS.initializer_files('mime') do |files|
        files.file_names.should include('mime_types.rb')
        files.file_names.should_not include('secret_token.rb')  
      end      
    end
  end
end  
