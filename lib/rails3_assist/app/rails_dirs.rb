module Rails::Assist
  module App                               
    class << self
      attr_accessor :rails_root_dir
    end      

    module RailsDirs      
      def self.root_directories
        [:app, :config, :db, :public, :lib, :log, :doc, :test, :spec]      
      end

      def root_directories
        Rails::Assist::App::RailsDirs.root_directories
      end

      def self.app_artifacts
        [:controller, :mailer, :helper, :view, :model, :permit]
      end
    
      def self.app_directories
        app_artifacts.map {|a| a.to_s.singularize.to_sym}
      end

      def app_directories
        Rails::Assist::App::RailsDirs.app_directories
      end

      def app_artifacts
        Rails::Assist::App::RailsDirs.app_artifacts
      end

      def self.rails_containers
        Rails::Assist::App::RailsDirs.instance_methods.grep(/_dir$/).map{|dir| dir.gsub(/^(.*)_dir/, '\1').to_sym }
      end

      def self.valid_container? type
        rails_containers.include?(type)
      end

      def root_dir options={}                                                                                    
        dir = options[:root_path] if options
        dir ||= Rails::Assist::App.rails_root_dir || Rails.root
        raise "You must set the Rails app root dir: Rails::Assist::App.root_dir = '/my/root/dir'" if !dir
        dir
      end    

      def rails_dir_for type, options={}
        raise ArgumentError, '#rails_dir_for takes a dir type argument' if !type
        dir_method = "#{type}_dir"
        self.send(dir_method, options) if respond_to?(dir_method)
      end
    
      def migration_dir options={}
        File.join(db_dir(options), 'migrations')
      end

      def config_dir_for type, options={}
        File.join(config_dir(options), type.to_s)
      end      

      def initializer_dir options={}
        config_dir_for type :initializers, options
      end  

      def locale_dir options={}
        config_dir_for type :locales, options
      end

      def public_dir_for type, options={}
        File.join(public_dir(options), type.to_s)
      end      

      def stylesheet_dir options={}
        public_dir_for :stylesheets, options
      end

      def javascript_dir options={}
        public_dir_for :javascripts, options
      end
         
      root_directories.each do |name|
        class_eval %{
          def #{name}_dir options={}
            File.join(root_dir(options), '#{name}')
          end        
        } 
      end

      app_artifacts.each do |name|
        class_eval %{
          def #{name}_dir options={}
            File.join(app_dir(options), '#{name}')
          end
        } 
      end    

      def app_dir options={}
        File.join(root_dir(options), 'app')
      end        

      def observer_dir options={}
        model_dir options
      end
    end # RailsDirs   
  end # App
end