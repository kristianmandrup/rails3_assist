module Rails3::Assist::App::Files
  module Special
    module Application
      def insert_application_config content=nil, &block
        file_insertion(application_file, content, :after => 'Rails::Application', &block)
      end  
    end
  end
end