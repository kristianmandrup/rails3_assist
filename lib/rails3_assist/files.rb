require 'rake'
require 'rails3_assist/directory'
require 'sugar-high/regexp'
require_all File.dirname(__FILE__) + '/files'

module Rails3::Assist
  module Files         
    # we depend on the Directories module doing some of the hard work!
    module Methods
      RYBY_FILES = '**/*.rb'
      
      def rails_app_files type = :app, options = {}
        dir = Rails3::Assist::Artifact::Directory.send "#{type.to_s.singularize}_dir"
        expr = options[:expr]
        file_pattern = options[:pattern] || RYBY_FILES
        pattern = "#{dir}/#{file_pattern}"
        files = FileList[pattern].to_a
        files = files.grep(expr.to_regexp) if expr
        files
      end
    
      def all_files expr=nil
        pattern = "#{Rails3::Assist::Directory::Root.root_dir}/**/*.*"
        files = FileList[pattern].to_a
        files = files.grep(expr.to_regexp) if expr
        files
      end  

      def app_files expr=nil
        rails_app_files(:app).grep expr
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
    end    
    
    include Methods
    extend Methods
  end # Files    
end # App                  
