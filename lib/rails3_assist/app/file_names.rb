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
    
    include FileName
  end

  module Migration
    module FileName   
      include Rails::Migration::Assist::ClassMethods      

      class FindError
        attr_accessor :find_expr
        
        def initialize find_expr
          self.find_expr = find_expr
        end
      end
      
      def migration_file_name name, options={}
        number = options[:number]      
        number = next_migration_number(migration_dir) if !number      
        File.join(migration_dir, "#{number}_#{name}.rb")      
      end
            
      def find_migration name, option=nil
        migration_find_expr = "#{migration_dir}/[0-9]*_*.rb"
        migrations = Dir.glob(migration_find_expr)
        
        find_err = FindError.new migration_find_expr
        
        return find_err if migrations.empty?  
        
        migration_find_expr = /\d+_#{name}\.rb$/
        find_err.find_expr = migration_find_expr
            
        matching_migrations = migrations.grep(migration_find_expr)

        return find_err if matching_migrations.empty?

        migration_file = (option == :last) ? matching_migrations.last : matching_migrations.first
      end      
    end
    
    include FileName 
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