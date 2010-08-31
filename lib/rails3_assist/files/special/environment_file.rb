module Rails3::Assist::App::Files
  module Special
    module Environment
      def insert_before_application_init content=nil, &block
        file_insertion(environment_file, content, :before => /\w+::Application.initialize!/, &block)      
      end

      def insert_after_application_init content=nil, &block
        insert_application_init :after => content, &block
      end

      protected

      def insert_application_init place, statement=nil, &block
        statement = block ? yield : "config.#{statement}"
        file_insertion(environment_file, statement, place => /\w+::Application.initialize!/)      
      end    
    end
  end
end