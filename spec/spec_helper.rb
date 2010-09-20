require 'rspec/core'
require 'rails3_assist'
require 'rails3_assist/rspec'
require 'rails-app-spec'
require 'tmpdir'

# RSpec::Generator.configure do |config|
#   config.debug = false
#   config.remove_temp_dir = false #true
#   config.default_rails_root(__FILE__) 
#   config.lib = File.dirname(__FILE__) + '/../lib'
#   config.logger = :stdout  
# end
#    

require 'fixtures'

def project_dir
  File.dirname(__FILE__) + '/..'
end

def temp_dir name
  File.join(project_dir, name)  
end

def make_temp_dir name   
  FileUtils.mkdir_p temp_dir(name)
  temp_dir(name)
end

def remove_temp_dir name   
  FileUtils.rm_rf temp_dir(name)
end

Rails3::Assist::Directory.rails_root = temp_dir('tmp_rails')

RSpec.configure do |config|
  config.mock_with :mocha
  config.after do
    remove_temp_dir 'tmp_rails'
  end
end

