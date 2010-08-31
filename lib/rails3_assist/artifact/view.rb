module Rails3::Assist::Artifact             
  module Files  
    def view_files *args 
      expr, model_name = Helper.get_view_args args
      file_expr = model_name ? "#{model_name.to_s.pluralize}/*.*" : '**/*.*'
      files = rails_app_files(:views, file_expr)
      files.grep(expr) if expr
      yield files if block_given?
      files          
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
        expr = args[1] if args.size > 1 && args1.kind_of?(Regexp)
        [expr, _model]
      end        
    end
  end
end