module Rails::Assist
  module App
    module RailsFiles

      def application_file
      end
      
      def environment_file
      end
    
      def files_from expr, *types
        types.inject([]) {|files, type| files + self.send(:"#{type}_files", expr)}
      end

      def all_files expr=nil
        rails_files(root_dir).grep expr
      end  

      def app_files expr=nil
        rails_app_files.grep expr
      end  

      def rails_files_for type, expr=nil, &block
        files_method = "#{type}_files"
        send files_method, expr, &block if respond_to?(files_method)
      end

      def self.rails_artifacts
        @rails_artifacts ||= Rails::Assist::RailsDirs.instance_methods.grep(/_files$/).map{|dir| dir.gsub(/^(.*)_dir/, '\1').to_sym }      
      end

      def self.valid_artifact? type
        rails_artifacts.include?(type)
      end

      [:model, :controller, :helper].each do |name|
        class_eval %{
          def #{name}_files expr=nil
            files = rails_app_files(:#{name.to_s.pluralize}).grep expr
            yield files if block_given?      
          end          
        }
      end
    
      # artifact files using xxx_[artifact].rb convention, i.e postfixing with type of artifact
      [:mailer, :observer, :permit].each do |name|
        class_eval %{
          def #{name}_files expr=nil
            files = rails_app_files(:#{name.to_s.pluralize}, '**/*_#{name}.rb').grep expr
            yield files if block_given?
          end  
        }
      end

      def view_files *args 
        expr, model_name = get_view_args args
        file_expr = model_name ? "#{model_name}/*.*" : '**/*.*'
        files = rails_app_files(:views, file_expr).grep expr
        yield files if block_given?          
      end


      [:erb, :haml].each do |name|
        class_eval %{
          def #{name}_view_files *args 
            expr, model_name = get_view_args(args)
            file_expr = model_name ? "\#{model_name}/*.\#{name}*" : '**/*.\#{name}*'
            files = rails_app_files(:views, file_expr).grep expr
            yield files if block_given?          
          end
        }
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
      
          def remove_#{plural_name} *names
            names.each do |name|
              File.delete #{name}_file(name)
            end
          end
          alias_method :remove_#{name}, :remove_#{plural_name} 
        }
      end

      protected
   
      RB_FILES = '**/*.rb'

      def get_view_args args 
        args = args.flatten
        first_arg = args.first      
        case first_arg
        when Regexp
          expr = first_arg
        when String, Symbol
          _model = first_arg
        end
        expr = args[1] if args > 1 && args1.kind_of?(Regexp)
        [expr, _model]
      end

      def rails_files dir, type=nil, pattern=nil
        path = case type
        when nil
          "#{dir}/#{RB_FILES}"
        when String          
          "#{dir}/#{type}"
        when Symbol
          pattern ? "#{dir}/#{type}/#{pattern}" : "#{dir}/#{type}"
        end
        FileList[path]
      end

      def rails_app_files type=nil, pattern='**/*.rb'
        rails_files :app, type, pattern
      end
    end    
  end # App                  
end