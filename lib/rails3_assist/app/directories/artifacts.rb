module Rails::Assist::Directories
  module Artifacts      
    def self.app_artifacts
      [:controller, :mailer, :helper, :view, :model, :permit]
    end

    def app_artifacts
      Rails::Assist::App::RailsDirs.app_artifacts
    end

    # :controller, :mailer, :helper, :view, :model, :permit
    #
    # controller_dir, mailer_dir ...
    app_artifacts.each do |name|
      class_eval %{
        def #{name}_dir options={}
          File.join(app_dir(options), '#{name}')
        end
      } 
    end    
    
    # initializer_dir, locale_dir
    # stylesheet_dir, javascript_dir    
    [:config => [:initializer, :locale], :public => [:stylesheet, :javascript] ].each_pair do |container, names|
      names.each do |name|
        class_eval %{      
          def #{name}_dir options={}
            #{container}_dir_for type :#{name.to_s.pluralize}, options
          end  
        }
      end
    end

    # :app, :config, :db, :public, :lib, :log, :doc, :test, :spec
    #
    # app_dir, config_dir ...
    root_directories.each do |name|
      class_eval %{
        def #{name}_dir options={}
          File.join(root_dir(options), '#{name}')
        end        
      } 
    end

    def migration_dir options={}
      File.join(db_dir(options), 'migrations')
    end

    def observer_dir options={}
      model_dir options
    end
  end
end