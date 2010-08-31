module Rails3::Assist::Directory
  module Root
    def self.root_directories
      [:app, :config, :db, :public, :lib, :log, :doc, :test, :spec]      
    end

    def root_directories
      Rails3::Assist::Directory::Root.root_directories
    end
    
    # ---

    def self.root_dir options={}
      dir = options[:root_path] if options
      dir ||= Rails3::Assist::Directory.rails_root || Rails.root
      raise "You must set the Rails app root dir: Rails::Assist::App.root_dir = '/my/root/dir'" if !dir
      dir
    end    
    
    def root_dir options={}
      Rails3::Assist::Directory::Root.root_dir options
    end
  end
end