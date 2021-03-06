module Rails3::Assist::Directory
  module Root
    module Methods
      def root_directories
        [:app, :config, :db, :public, :lib, :log, :doc, :test, :spec]      
      end

      def root_dir options={}
        raise ArgumentError, "options argument to root_dir must be a hash, was: #{options.inspect}" if options && !options.kind_of?(Hash)
        dir = options[:root_path] if options 
        dir ||= Rails3::Assist::Directory.rails_root || Rails.root
        raise "You must set the Rails app root dir: Rails::Assist::App.root_dir = '/my/root/dir'" if !dir
        dir
      end
    end    
    
    include Methods
    extend Methods
  end
end