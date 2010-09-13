require 'rake'
require 'rails3_assist/directory'
require 'sugar-high/regexp'

require_all File.dirname(__FILE__) + '/file'

module Rails3::Assist
  module Files         
    # we depend on the Directories module doing some of the hard work!
    module Methods
      RYBY_FILES = '**/*.rb'
      
      def rails_app_files type = :app, options = {}
        dir = Rails3::Assist::Directory.send "#{type.to_s.singularize}_dir"
        expr = options[:expr]
        file_pattern = options[:pattern] || RYBY_FILES
        pattern = "#{dir}/#{file_pattern}"
        FileList[pattern].to_a.grep_it expr
      end
    
      def all_files expr=nil
        pattern = "#{Rails3::Assist::Directory::Root.root_dir}/**/*.*"
        FileList[pattern].to_a.grep_it expr 
      end  

      def app_files expr=nil
        rails_app_files(:app).grep_it expr
      end  

      # files_from :model, :controller, :matching => /user/
      def files_from *types, &block
        expr = last_option(types)[:matching]
        the_files = types.inject([])  do |files, type|
          method = :"#{type}_files"               
          files_found = send(method, expr) if respond_to?(method)
          files_found = Rails3::Assist::Artifact::Files.send(method, expr) if Rails3::Assist::Artifact::Files.respond_to?(method)
          files + files_found
        end.compact
        yield the_files if block
        the_files        
      end

      def with_files_from type, expr=nil, &block
        method = "#{type}_files"
        send method, expr, &block if respond_to?(method)
      end


      [:initializer, :db, :migration].each do |name|
        class_eval %{
          def #{name}_files expr=nil
            files = rails_app_files :#{name}, :expr => expr
            yield files if block_given?
            files
          end  
        }
      end

      {:locale => :yml, :javascript => :js}.each_pair do |name, ext|
        class_eval %{
          def #{name}_files expr=nil
            files = rails_app_files(:#{name}, :pattern => '**/*.#{ext}', :expr => expr)
            yield files if block_given?
            files
          end
        }
      end

      [:css, :sass].each do |ext|
        class_eval %{
          def #{ext}_files expr=nil
            files = rails_app_files :stylesheets, :pattern => '**/*.#{ext}', :expr => expr
            yield files if block_given?
            files
          end
        }
      end
      
      Rails3::Assist::Artifact.app_artifacts.each do |name|
        plural_name = name.to_s.pluralize
        class_eval %{
          def remove_all_#{plural_name}
            Rails3::Assist::Artifact::Files.#{name}_files.each{|f| ::File.delete_file! f}
          end
          alias_method :delete_all_#{plural_name}, :remove_all_#{plural_name}           

          def remove_#{plural_name} *names
            return remove_all_#{plural_name} if names.empty? 
            names.to_strings.each do |name|
              ::File.delete #{name}_file(name)
            end
          end
          alias_method :delete_#{plural_name}, :remove_#{plural_name} 
          alias_method :remove_#{name}, :remove_#{plural_name} 
          alias_method :delete_#{name}, :remove_#{plural_name}           
        } 
      end    
    end    
    
    include Methods
    extend Methods
  end # Files    
end # App                  
