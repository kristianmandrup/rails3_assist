module Rails3::Assist
  module File
    module Methods
      {:initializer => '.rb', :db => '.rb', :migration => '.rb', :locale => '.yml', :javascript => 'js', :stylesheet => 'css'}.each_pair do |name, ext|
        plural_name = name.to_s.pluralize

        class_eval %{      
          def #{name}_file? name
            File.file? #{name}_file(name)
          end            
          
          def #{name}_file name
            name = (name =~ /.rb$/) ? name : "\#{name}#{ext}'
            ::File.join(Rails3::Assist::Artifact::Directory.#{name}_dir, name)
          end  

          def create_#{name} name, &block
            ::File.overwrite #{name}_file(name) do
              yield
            end
          end

          def remove_all_#{plural_name}
            #{name}_files.each{|f| ::File.delete_file! f}
          end

          def remove_#{plural_name} *names
            return remove_all_#{plural_name} if names.empty? 
            names.to_strings.each do |name|
              ::File.delete #{name}_file(name)
            end
          end
          alias_method :remove_#{name}, :remove_#{plural_name} 
        }
      end
    end
    
    include Methods
    extend Methods
  end
end   

