module Rails3::Assist
  module File
    module Methods
      {:initializer => 'rb', :db => 'rb', :migration => 'rb', :locale => 'yml', :javascript => 'js', :stylesheet => 'css'}.each_pair do |name, ext|
        plural_name = name.to_s.pluralize
        pure_ext = ext.gsub /^\./, ''
        class_eval %{      
          def #{name}_file? name
            name = (name =~ /.rb$/) ? name : "\#{name}.#{pure_ext}"            
            ::File.file? #{name}_file(name)
          end            
          alias_method :has_#{name}_file?, :#{name}_file?

          def #{name}_files? *names
            names.to_strings.each do |name|
              return false if !#{name}_file?(name)
            end
            true
          end            
          
          def #{name}_file name
            name = (name =~ /.rb$/) ? name : "\#{name}.#{pure_ext}"
            ::File.join(Rails3::Assist::Artifact::Directory.#{name}_dir, name)
          end  

          def create_#{name} name, &block
            Rails3::Assist.create_empty_tmp #{name}_dir if !::File.directory?(Rails3::Assist::Artifact::Directory.#{name}_dir)
            ::File.overwrite #{name}_file(name) do
              yield
            end
          end

          def remove_all_#{plural_name}
            return if !::File.directory?(Rails3::Assist::Artifact::Directory.#{name}_dir)
            #{name}_files.each{|f| ::File.delete_file! f}
          end

          def remove_#{plural_name} *names
            return remove_all_#{plural_name} if names.empty? 
            names.to_strings.each do |name|
              name = (name =~ /.rb$/) ? name : "\#{name}.#{pure_ext}"
              file_name = #{name}_file(name)
              ::File.delete file_name if ::File.file?(file_name)
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

