require 'rspec'
require 'rspec/autorun'     

require 'require_all'

require 'fixtures'
require 'sugar-high/file'

require 'rails3_assist/namespaces'
require 'rails3_assist/directory'
require 'rails3_assist/file'

CLASS = Rails3::Assist::File

class AppDir
  include CLASS
end

describe Rails3::Assist::File do
  # use_helper :directories

  before do
    Rails3::Assist::Directory.rails_root = fixtures_dir
  end

  describe '#initializer_file' do
    it "should return the initializer file 'mime_type' " do
      CLASS.initializer_file('mime_type').should match /mime_type/
    end
  end    

  describe '#create_initializer' do
    it "should create the initializer file 'my_init' " do
      name = 'my_init'
      CLASS.create_initializer(name) do
        'hello'
      end
      CLASS.initializer_file(name).should match /#{name}/
    end
  end    

  describe '#remove_initializers' do
    before do         
      name = 'my_init' 
      CLASS.create_initializer(name) do
        'hello'
      end
    end
    
    it "should remove the initializer files named 'my_init' " do
      name = 'my_init'
      File.exist?(CLASS.initializer_file(name)).should be_true
      CLASS.remove_initializers(name)
      File.exist?(CLASS.initializer_file(name)).should be_false
    end
  end
end