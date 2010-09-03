module Rails3::Assist::File
  module Environment
    def insert_before_application_init content=nil, &block
      insert_application_init :before, content, &block
    end

    def insert_after_application_init content=nil, &block
      insert_application_init :after, content, &block
    end

    def insert_application_init place, statement=nil, &block
      File.insert_into environment_file, statement, place => /\w+::Application.initialize!/
    end    
  end
end