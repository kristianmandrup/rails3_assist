require 'spec_helper'

CLASS = Rails3::Assist::File

class AppDir
  extend Rails3::Assist::UseMacro
  use_helper :file
end

describe Rails3::Assist::File do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = fixtures_dir
  end

  before :each do
    CLASS.remove_initializer('my_init')    
  end

  describe '#initializer_filepath' do
    it "should return the initializer file 'mime_types' " do
      AppDir.new.initializer_filepath('mime_types').should match /mime_type/
    end
  end    

  describe '#initializer_file' do
    it "should return the initializer file 'mime_type' " do
      AppDir.new.initializer_file('mime_types').path.should match /mime_type/
    end
  end    

  describe '#create_initializer' do
    it "should create the initializer file 'my_init' " do
      name = 'my_init'
      CLASS.create_initializer(name) do
        'hello'
      end
      CLASS.initializer_file(name).path.should match /#{name}/
      CLASS.read_initializer(name).should match /hello/
    end
  end    

  describe '#read_initializer' do
    it "should create replace initializer content using hash args" do      
      name = 'my_init'   
      CLASS.create_initializer(name) do
        'hello'
      end      
      CLASS.read_initializer(name).should match /hello/
      CLASS.remove_initializer(name)      
    end
  end

  describe '#read_initializer_file' do
    it "should create replace initializer content using hash args" do      
      name = 'my_init'   
      CLASS.create_initializer(name) do
        'hello'
      end      
      CLASS.read_initializer_file(name).should match /hello/
    end
  end


  describe '#replace_initializer_content' do
    it "should create replace initializer content using hash args" do      
      name = 'my_init'   
      CLASS.create_initializer(name) do
        'hello'
      end
      CLASS.replace_initializer_content name, :where => 'hello', :with => 'goodbye'
      
      CLASS.read_initializer(name).should match /goodbye/
      CLASS.read_initializer(name).should_not match /hello/
    end

    it "should create replace initializer content using hash arg and block" do
      name = 'my_init'
      CLASS.create_initializer(name) do
        'hello'
      end
      CLASS.replace_initializer_content name, :where => 'hello' do
        'goodbye'
      end
      
      CLASS.read_initializer(name).should match /goodbye/
      CLASS.read_initializer(name).should_not match /hello/
    end
  end    

  describe '#create_javascript' do
    it "should create the javascript file 'my_init' " do
      name = :effects
      CLASS.create_javascript(name) do
        'js stuff'
      end
      CLASS.read_javascript(name).should match /js stuff/
    end
  end    


  describe '#remove_initializers' do
    it "should remove the initializer files named 'my_init' " do
      name = 'my_init' 
      CLASS.create_initializer(name) do
        'hello'
      end

      CLASS.read_initializer(name).should match /hello/
      CLASS.remove_initializer(name)
      CLASS.read_initializer(name).should be_nil
    end
  end
end