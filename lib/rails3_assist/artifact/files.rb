require 'sugar-high/regexp'

module Rails3::Assist::Artifact
  module Files  
    module Methods  
      [:model].each do |name|
        class_eval %{
          def #{name}_files expr=nil
            files = Rails3::Assist::Files.rails_app_files(:#{name.to_s.pluralize}).grep_it expr
            yield files if block_given?
            files
          end          
        }
      end

      # artifact files using xxx_[artifact].rb convention, i.e postfixing with type of artifact
      [:mailer, :observer, :permit, :controller, :helper].each do |name|
        class_eval %{
          def #{name}_files expr=nil
            files = Rails3::Assist::Files.rails_app_files(:#{name.to_s.pluralize}, :pattern => '**/*_#{name}.rb').grep_it expr
            yield files if block_given?
            files
          end  
        }
      end   

      def view_files *args 
        expr, model_name = Helper.get_view_args args
        ext = last_option(args)[:template_language] || 'erb'
        pattern = model_name ? "#{model_name.to_s.pluralize}/*.#{ext}*" : "**/*.#{ext}*"
        files = Rails3::Assist::Files.rails_app_files(:views, :pattern => pattern).grep_it expr
        yield files if block_given?
        files          
      end


      [:erb, :haml].each do |name|
        class_eval %{
          def #{name}_view_files *args 
            view_files args, :template_language => :#{name}
          end
        }
      end
    end
    extend Methods
    include Methods

    module Helper    
      def self.get_view_args args 
        args = args.flatten
        first_arg = args.first      
        case first_arg
        when Regexp
          expr = first_arg
        when String, Symbol
          _model = first_arg
        end
        expr = args[1] if args.size > 1 && args[1].kind_of?(Regexp)
        [expr, _model]
      end        
    end
  end
end