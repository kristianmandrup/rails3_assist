require_all File.dirname(__FILE__) + '/files'

module Rails::Assist::App
  module Files         
    # in order to resolve any files 
    # we depend on the Directories module doing some of the hard work!
    include Directories    
    
    def all_files expr=nil
      rails_files(root_dir).grep expr
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

    protected
 
    include Helpers
    
  end # Files    
end # App                  
