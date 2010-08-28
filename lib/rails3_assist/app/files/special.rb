module Rails::Assist::App::Files
  module Special
    # application_file, environment_file
    [:application, :environment].each do |name|
      class_eval %{
        def #{name}_file
          File.join(config_dir, '#{name}.rb')
        end         
      }
    end  

    def seed_file
      File.join(db_dir, 'seed.rb')
    end
    
    # read_application_file
    # append_to_application_file
    [:application, :environment, :seed].each do |name|
      class_eval %{      
        def read_#{name}_file     
          fname = #{name}_file
          File.read(fname) if File.file?(fname)
        end

        def append_to_#{name}_file content=nil, &block
          File.append(#{name}_file, content, &block)
        end
      }
    end    
  end
end