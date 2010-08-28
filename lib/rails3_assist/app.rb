module Rails::Assist  
  def self.helper_list
    self.artifacts + [:view]
  end

  module ArtifactPath
    def artifact_path name, type, options={}
      dir = send :"#{type}_dir", options[:root_path] 
      File.join(dir, "#{name}#{type_postfix type}.rb")
    end

    def type_postfix type
      "_#{type}" if ![:model].include?(type)
    end
  end
  
  module App
    include ArtifactPath
    
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
module Rails::Assist::App
  # put all FileName modules into App
  Rails::Assist.helper_list.each do |name|
    class_eval %{
      include Rails::Assist::#{name.to_s.camelize}::FileName
    } 
  end
end                