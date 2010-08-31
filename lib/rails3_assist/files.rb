require 'rake'
require 'rails3_assist/directory'
require_all File.dirname(__FILE__) + '/files'

module Rails3::Assist
  module Files         
    # we depend on the Directories module doing some of the hard work!

    def rails_app_files type=nil, file_pattern='**/*.rb'
      dir = Rails3::Assist::Artifact::Directory.send "#{type.to_s.singularize}_dir"
      pattern = "#{dir}/#{file_pattern}"
      FileList[pattern].to_a
    end
    
    def all_files expr=nil
      rails_files(Rails3::Assist::Directory::Root.root_dir).grep expr
    end  

    def app_files expr=nil
      rails_app_files.grep expr
    end  

    # files_from :model, :controller, :matching => /user/
    def files_from *types
      expr = last_option(types)[:matching]        
      types.inject([]) {|files, type| files + self.send(:"#{type}_files", expr)}
    end

    def with_files_from type, expr=nil, &block
      files_method = "#{type}_files"
      send files_method, expr, &block if respond_to?(files_method)
    end


    [:initializer, :db, :migration].each do |name|        
      class_eval %{
        def #{name}_files expr=nil
          files = rails_files(#{name}_dir).grep expr
          yield files if block_given?          
        end  
      }
    end

    {:locale => :yml, :javascript => :js}.each_pair do |name, ext|
      class_eval %{
        def #{name}_files expr=nil
          files = rails_files(#{name}_dir, '**/*.#{ext}').grep expr
          yield files if block_given?                    
        end
      }
    end

    [:css, :sass].each do |ext|
      class_eval %{
        def #{ext}_files expr=nil
          files = rails_files(stylesheet_dir, '**/*.#{ext}').grep expr
          yield files if block_given?                    
        end
      }
    end    
  end # Files    
end # App                  
