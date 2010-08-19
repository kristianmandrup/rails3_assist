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
        [:controller, :mailer, :helper, :view, :model]
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

      def root_dir                                                                                    
        dir = Rails::Assist::App.rails_root_dir || Rails.root
        raise "You must set the Rails app root dir: Rails::Assist::App.root_dir = '/my/root/dir'" if !dir
        dir
      end    

      def rails_dir_for type
        raise ArgumentError, '#rails_dir_for takes a dir type argument' if !type
        dir_method = "#{type}_dir"
        self.send(dir_method) if respond_to?(dir_method)
      end
    
      def migration_dir
        File.join(db_dir, 'migrations')
      end

      def config_dir_for type
        File.join(config_dir, type.to_s)
      end      

      def initializer_dir
        config_dir_for type :initializers
      end  

      def locale_dir
        config_dir_for type :locales
      end

      def public_dir_for type
        File.join(public_dir, type.to_s)
      end      

      def stylesheet_dir
        public_dir_for :stylesheets
      end

      def javascript_dir
        public_dir_for :javascripts
      end
         
      root_directories.each do |name|
        class_eval %{
          def #{name}_dir
            File.join(root_dir, '#{name}')
          end        
        } 
      end

      app_artifacts.each do |name|
        class_eval %{
          def #{name}_dir      
            File.join(app_dir, '#{name}')
          end
        } 
      end    

      def app_dir
        File.join(root_dir, 'app')
      end        

      def observer_dir
        model_dir
      end
    end # RailsDirs   
  end # App
end