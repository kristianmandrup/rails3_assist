require_all File.dirname(__FILE__) + '/directory'
require 'rails3_assist/artifact/directory'

module Rails3::Assist
  module Directory      
    class << self
      attr_accessor :rails_root
    end    

    include Root
    include App
    include Container    
        
    # dir_for helpers
    # -------------------

    module Methods   
      DIR = Rails3::Assist::Artifact::Directory      
      
      # :app, :config, :db, :public, :lib, :log, :doc, :test, :spec
      #
      # app_dir, config_dir ...
      Rails3::Assist::Directory::Root.root_directories.each do |name|
        class_eval %{
          def #{name}_dir options={}
            ::File.join(Rails3::Assist::Directory::Root.root_dir(options), '#{name}')
          end        
        } 
      end      
      
      def rails_dir_for type, options={}
        raise ArgumentError, '#rails_dir_for takes a dir type argument' if !type
        dir_method = "#{type}_dir"
        return send(dir_method, options) if respond_to?(dir_method)
        DIR.send(dir_method, options) if DIR.respond_to?(dir_method)
      end

      def app_dir_for type, options={}
        ::File.join(app_dir(options), type.to_s.pluralize)
      end      

      def config_dir_for type, options={}
        ::File.join(config_dir(options), type.to_s.pluralize)
      end      

      def public_dir_for type, options={}
        ::File.join(public_dir(options), type.to_s.pluralize)
      end                
    end
    
    include Methods
    extend Methods
    
  end # Directories   
end
