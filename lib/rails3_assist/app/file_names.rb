require 'migration_assist'

module Rails::Assist
  module View
    module FileName
      DEFAULT_TEMPLATE_LANG = 'html.erb'
      DEFAULT_REST_ACTION = 'show'
          
      def view_file_name folder, *args
        action, type, args = get_view_args(args)
        File.expand_path File.join(view_dir, folder.to_s, "#{action}.#{type}")
      end 
      
      def get_view_args args 
        args = args.flatten
        action  = DEFAULT_REST_ACTION
        type    = DEFAULT_TEMPLATE_LANG
        case args.first
        when Hash
          action = args.first.delete(:action)
          type = args.first.delete(:type)
        when String, Symbol     
          action = args.delete_at(0)
        end
        case args.first
        when String, Symbol        
          type = args.delete_at(0)
        end      
        [action, type, args]
      end
    end
  end

  module Migration
    module FileName   
      include Rails::Migration::Assist::ClassMethods      
      
      def migration_file_name name, options={}
        number = options[:number]      
        number = next_migration_number(migration_dir) if !number      
        File.join(migration_dir, "#{number}_#{name}.rb")      
      end
            
      def find_migration name, option=nil
        migrations = Dir.glob("#{migration_dir}/[0-9]*_*.rb")
        return nil if migrations.empty?      
        matching_migrations = migrations.grep(/\d+_#{name}\.rb$/)
        return nil if matching_migrations.empty?
        migration_file = (option == :last) ? matching_migrations.last : matching_migrations.first
      end      
    end
  end 
  
  (Rails::Assist.artifacts. - [:migration, :view]).each do |name|
    class_eval %{
      module #{name.to_s.camelize}
        module FileName
        
          def #{name}_file_name name, options=nil
            artifact_path name, :#{name}
          end        
        end
        
        include FileName
      end
    }
  end
end  