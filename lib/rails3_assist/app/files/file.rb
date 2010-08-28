module Rails::Assist::App
  module File
    [:initializer, :db, :migration, :locale, :javascript, :stylesheet] do |name|
      plural_name = name.to_s.pluralize

      class_eval %{      
        def #{name}_file name
          File.join(#{name}_dir, name)
        end  

        def create_#{name} name, &block
          File.overwrite #{name}_file(name) do
            yield
          end
        end                      

        def remove_all_#{plural_name}
          #{name}_files.each{|f| File.delete_file! f}
        end

        def remove_#{plural_name} *names
          return remove_all_#{plural_name} if names.empty? 
          names.each do |name|
            File.delete #{name}_file(name)
          end
        end
        alias_method :remove_#{name}, :remove_#{plural_name} 
      }
    end
  end
end