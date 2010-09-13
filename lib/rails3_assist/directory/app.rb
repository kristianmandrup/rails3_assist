module Rails3::Assist::Directory
  module App  
    module Methods
      def app_directories
        Rails3::Assist::Artifact::app_artifacts.map {|a| a.to_s.pluralize.to_sym}
      end

      def app_dir options={}
        rails_root_dir = Rails3::Assist::Directory::Root.root_dir(options)
        File.join(rails_root_dir, 'app')
      end
    end
    
    include Methods
    extend Methods
  end
end