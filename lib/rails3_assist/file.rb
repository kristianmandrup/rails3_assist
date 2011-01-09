require_all File.dirname(__FILE__) + '/file'
# require 'sugar-high/file'

module Rails3::Assist
  module File
    module Methods
      {:initializer => 'rb', :db => 'rb', :migration => 'rb', :locale => 'yml', :javascript => 'js', :stylesheet => 'css', :config => '.rb', :db => '.rb'}.each_pair do |name, ext|
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
          
          def #{name}_filepath name
            name = (name =~ /.rb$/) ? name : "\#{name}.#{pure_ext}"
            ::File.join(Rails3::Assist::Artifact::Directory.#{name}_dir, name)
          end  

          def #{name}_file name
            ::File.new(#{name}_filepath name)
          end  

          def create_#{name} name, &block
            dir_name = Rails3::Assist::Artifact::Directory.#{name}_dir
            Rails3::Assist::App.create_empty_tmp :#{name} if !::File.directory?(dir_name)
            ::File.overwrite #{name}_filepath(name) do
              yield
            end
          end

          def read_#{name} name
            file_name = #{name}_filepath(name)
            ::File.read(file_name) if ::File.file?(file_name)
          end
          alias_method :read_#{name}_file, :read_#{name}

          def replace_#{name}_content name, args = {}, &block
            if !(args.kind_of?(Hash) && args[:where])
              raise ArgumentError, "#replace_#{name}_content Must take a hash argument with a :where option that is the content to be matched and replaced" 
            end            

            replace_content = block ? yield : args[:with]
            if !replace_content            
              raise ArgumentError, "#replace_#{name}_content Must take a block or a :with hash option that is the content to replace with" 
            end

            ::File.replace_content_from #{name}_filepath(name), :where => args[:where], :with => replace_content
          end

          def remove_all_#{plural_name}
            return if !::File.directory?(Rails3::Assist::Artifact::Directory.#{name}_dir)
            #{name}_files.each{|f| ::File.delete_file! f}
          end

          def remove_#{plural_name} *names
            return remove_all_#{plural_name} if names.empty? 
            names.to_strings.each do |name|
              name = (name =~ /.rb$/) ? name : "\#{name}.#{pure_ext}"
              file_name = #{name}_filepath(name)                 
              puts "file not there" if !::File.file?(file_name)
              ::File.delete(file_name) if ::File.file?(file_name)
            end
          end
          alias_method :remove_#{name}, :remove_#{plural_name} 
        }
      end
    end

    include Special
    extend Special
    
    include Methods
    extend Methods
  end
end   

