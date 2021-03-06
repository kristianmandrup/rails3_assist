module Rails3::Assist::Artifact
  module Directory
    module Methods
      DIR = Rails3::Assist::Directory
      APP_DIR = Rails3::Assist::Directory::App
      
      # :controller, :mailer, :helper, :view, :model, :permit
      #
      # controller_dir, mailer_dir ...
      Rails3::Assist::Artifact.app_artifacts.each do |name|
        class_eval %{
          def #{name}_dir options={}
            File.join(APP_DIR.app_dir(options), '#{name.to_s.pluralize}')
          end
        } 
      end    
        
      # initializer_dir, locale_dir
      # stylesheet_dir, javascript_dir    
      {:config => Rails3::Assist.specials(:config), :public => Rails3::Assist.specials(:public)}.each_pair do |container, names|
        names.each do |name|
          class_eval %{      
            def #{name}_dir options={}
              Rails3::Assist::Directory.#{container}_dir_for :#{name.to_s.pluralize}, options
            end  
          }
        end
      end
      
      def migration_dir options={}
        File.join(DIR.db_dir(options), 'migrations')
      end
      
      def observer_dir options={}
        model_dir options
      end
    end

    extend Methods
    include Methods
  end
end
