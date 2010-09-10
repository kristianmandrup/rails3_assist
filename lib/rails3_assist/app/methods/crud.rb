module Rails::Assist
  artifacts.each do |name|
    class_eval %{
      module #{name.to_s.camelize}      
        include Rails::Assist::BaseHelper
        
        def create_#{name} name, options={}, &block
          create_artifact(name, set(options, :#{name}), &block)
        end          
      
        def insert_into_#{name}(name, options={}, &block)
          insert_content(name, set(options, :#{name}), &block)      
        end
        
        def read_#{name}(name, options={}, &block)
          read_artifact(name, set(options, :#{name}), &block)      
        end

        def remove_#{name} name
          remove_artifact name, :#{name}
        end
    
        def remove_#{name}s *names      
          remove_artifacts :#{name}, *names
        end              
        
        aliases_for :#{name}            
      end
    }    
  end
end