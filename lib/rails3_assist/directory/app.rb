module Rails3::Assist::Directory
  module App  
    def self.app_directories
      Rails3::Assist::Artifact::app_artifacts.map {|a| a.to_s.pluralize.to_sym}
    end

    def app_directories
      Rails3::Assist::Directory::App.app_directories
    end

    def self.app_dir options={}
      rails_root_dir = Rails3::Assist::Directory::Root.root_dir(options)
      File.join(rails_root_dir, 'app')
    end
    
    def app_dir options={}
      Rails3::Assist::Directory::App.app_dir options
    end
  end
end