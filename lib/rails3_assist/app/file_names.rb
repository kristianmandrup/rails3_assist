module Rails::Assist
  module View
    module FileName    
      def view_file_name folder, action=nil, type=nil
        action = get_action(action)                
        type = get_type(type)
        File.expand_path File.join(view_dir, folder.to_s, "#{action}.#{type}")
      end
    end
  end

  module Migration
    module FileName
      def migration_file_name name, options={}
        number = options[:number]      
        number = next_migration_number(migration_dir) if !number      
        File.join(migration_dir, "#{number}_#{name}.rb")      
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