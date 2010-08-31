require_all File.dirname(__FILE__) + '/directory'
require 'rails3_assist/artifact'

module Rails3::Assist
  module Directory      
    class << self
      attr_accessor :rails_root
    end    

    include Root
    include App
    include Container    
    include Rails3::Assist::Artifact::Directory
    
    # dir_for helpers
    # -------------------

    def rails_dir_for type, options={}
      raise ArgumentError, '#rails_dir_for takes a dir type argument' if !type
      dir_method = "#{type}_dir"
      self.send(dir_method, options) if respond_to?(dir_method)
    end

    def app_dir_for type, options={}
      File.join(app_dir(options), type.to_s.pluralize)
    end      

    def config_dir_for type, options={}
      File.join(config_dir(options), type.to_s.pluralize)
    end      

    def public_dir_for type, options={}
      File.join(public_dir(options), type.to_s.pluralize)
    end                
  end # Directories   
end

require 'rails3_assist/artifact'