require 'spec_helper'

CLASS = Rails3::Assist::File::Special

class AppDir
  extend Rails3::Assist::UseMacro
  use_helper :special
end

def test_routes_file &block
  old_content = AppDir.new.read_routes_file

  yield if block

  File.overwrite CLASS.routes_file do
    old_content
  end            
end  

def test_gem_file &block
  old_content = AppDir.new.read_gem_file

  yield if block

  File.overwrite CLASS.gem_file do
    old_content
  end            
end  

describe Rails3::Assist::File::Special do
  before do
    Rails3::Assist::Directory.rails_root = fixtures_dir     
  end

  [:application, :environment, :seed, :routes, :boot].each do |name|
    eval %{
      before :each do                   
        file_name = CLASS.#{name}_file
        FileUtils.cp file_name, file_name + '.bak'
      end

      after :each do                  
        file_name = CLASS.#{name}_file        
        FileUtils.mv file_name + '.bak', file_name        
      end

      describe '##{name}_file' do
        it "should return the #{name} file path" do
          AppDir.new.#{name}_file.should match /#{name}s?\\.rb/
        end
      end

      describe '#remove_#{name}_file' do
        it "should return the #{name} file path" do
          file_name = CLASS.#{name}_file
          CLASS.remove_#{name}_file if File.exist?(file_name + '.bak')
          File.exist?(file_name).should be_false 
        end
      end  

      describe '#read_#{name}_file' do
        it "should read the #{name} file content" do
          content = CLASS.read_#{name}_file
          content.should_not be_empty
        end
      end

      describe '#append_to_#{name}_file' do
        it "should read the #{name} file content" do
          CLASS.append_to_#{name}_file do
            'hello'
          end
          content = CLASS.read_#{name}_file
          content.should match /hello$/
        end
      end
    }
  end
  
  describe '#gem_file' do
    it 'should return the Gemfile path' do
      AppDir.new.gem_file.should match /Gemfile/
    end
  end

  # create test_routes macro

  describe '#insert_into_routes' do  
    it 'should insert into block of Routes file' do
      test_routes_file do
        routes_stmt = 'devise_for :users'
        CLASS.insert_into_routes routes_stmt
        AppDir.new.read_routes_file.should match /do\s*#{Regexp.escape(routes_stmt)}\s*/
      end            
    end
  end
  
  describe '#read_gem_file' do  
    it 'should read the Gemfile' do
      AppDir.new.read_gem_file.should match /gem 'rails'/
    end
  end

  describe '#has_gem?' do    
    it 'should be true that it has the rails gem' do
      AppDir.new.has_gem?(:rails).should be_true
    end

    it 'should be false that it has the rails2 gem' do
      AppDir.new.has_gem?(:rails2).should be_false
    end
  end

  describe '#clean_gemfile' do    
    it 'should be true that it has cleaned the Gemfile ensuring newlines between each gem' do
      test_gem_file do
        CLASS.append_to_gem_file do
          "gem 'hello'gem 'hi'gem 'blip'"
        end

        AppDir.new.clean_gemfile
        expected = "gem 'hello'\ngem 'hi'"
        AppDir.new.read_gem_file.should match /#{Regexp.escape(expected)}/
      end
    end

    it 'should be true that it has cleaned the Gemfile ensuring newlines between each gem and after end' do
      test_gem_file do
        CLASS.append_to_gem_file do
          "group :dev endgem 'hi'gem 'blip'"
        end

        AppDir.new.clean_gemfile
        expected = "group :dev end\ngem 'hi'"
        AppDir.new.read_gem_file.should match /#{Regexp.escape(expected)}/
      end
    end
  end

  describe '#has_gem_version?' do    
    it 'should be true that it has the rails gem 3.0.3' do
      # puts AppDir.new.read_gem_file      
      AppDir.new.has_gem_version?(:rails, '3.0.3').should be_true
    end

    it 'should be false that it has the rails gem 3.0.1' do
      AppDir.new.has_gem_version?(:rails, '3.0.1').should be_false
    end
  end
end