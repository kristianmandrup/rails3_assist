module Rails3::Assist    
  module App    
    def create_empty_tmp *dir_types
      dir_types.flatten.each do |dir_type|
        dir = rails_dir_for(dir_type)
        FileUtils.mkdir_p dir
      end
    end                              
  end  
end

# first load all base modules that the app helper will build upon
require 'rails3_assist/base'

# then load the app 'modules'
require_all File.dirname(__FILE__) + '/app'

# into App
module Rails3::Assist::App
  # put all FileName modules into App
  Rails3::Assist.helper_list.each do |name|
    class_eval %{
      include Rails3::Assist::#{name.to_s.camelize}::FileName
    } 
  end
end                