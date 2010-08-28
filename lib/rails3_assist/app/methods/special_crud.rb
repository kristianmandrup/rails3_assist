module Rails::Assist
  module App   
    module ApplicationFile
      def insert_application_config content=nil, &block
        file_insertion(application_file, :after => 'Rails::Application', content, &block)
      end  
    end

    module EnvironmentFile
      def insert_before_application_init content=nil, &block
        file_insertion(environment_file, :before => /\w+::Application.initialize!/, content, &block)      
      end

      def insert_after_application_init content=nil, &block
        insert_application_init :after, content, &block
      end
    
      protected
    
      def insert_application_init place, statement=nil, &block
        statement = block ? yield : "config.#{statement}"
        file_insertion(environment_file, place => /\w+::Application.initialize!/, statement)      
      end    
    end
    
    module SeedFile
      def seed_file
        File.join(db_dir, 'seed.rb')
      end  
  
      def create_seed_file &block
        File.overwrite seed_file do
          yield
        end
      end                      

      def append_seed_file &block
        File.append seed_file do
          yield
        end
      end                      
  
      def remove_seed_file
        File.delete seed_file
      end      
    end
    
    include ApplicationFile, EnvironmentFile, SeedFile
  end
end