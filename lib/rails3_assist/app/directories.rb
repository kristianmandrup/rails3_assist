require_all File.dirname(__FILE__) + '/directories'

module Rails::Assist::App
  class << self
    attr_accessor :rails_root_dir
  end      

  module Directories      
    def self.root_directories
      [:app, :config, :db, :public, :lib, :log, :doc, :test, :spec]      
    end

    def root_directories
      Rails::Assist::App::RailsDirs.root_directories
    end
  
    def self.app_directories
      app_artifacts.map {|a| a.to_s.singularize.to_sym}
    end

    def app_directories
      Rails::Assist::App::RailsDirs.app_directories
    end

    def root_dir options={}                                                                                    
      dir = options[:root_path] if options
      dir ||= Rails::Assist::App.rails_root_dir || Rails.root
      raise "You must set the Rails app root dir: Rails::Assist::App.root_dir = '/my/root/dir'" if !dir
      dir
    end    

    def app_dir options={}
      File.join(root_dir(options), 'app')
    end  
    
    # dir_for helpers
    # -------------------

    def rails_dir_for type, options={}
      raise ArgumentError, '#rails_dir_for takes a dir type argument' if !type
      dir_method = "#{type}_dir"
      self.send(dir_method, options) if respond_to?(dir_method)
    end

    def config_dir_for type, options={}
      File.join(config_dir(options), type.to_s)
    end      

    def public_dir_for type, options={}
      File.join(public_dir(options), type.to_s)
    end                
  end # Directories   
end