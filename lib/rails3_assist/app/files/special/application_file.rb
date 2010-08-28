module Rails::Assist::App::Files
  module Special
    module Application
      def insert_application_config content=nil, &block
        file_insertion(application_file, :after => 'Rails::Application', content, &block)
      end  
    end
  end
end