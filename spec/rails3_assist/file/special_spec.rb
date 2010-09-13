require 'spec_helper'

CLASS = Rails3::Assist::File::Special

class AppDir
  include CLASS
end

describe Rails3::Assist::File::Special do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = fixtures_dir     
    # puts Rails3::Assist::Directory.methods.sort
  end

  [:application, :environment, :seed].each do |name|
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
          CLASS.#{name}_file.should match /#{name}s?\\.rb/
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
end