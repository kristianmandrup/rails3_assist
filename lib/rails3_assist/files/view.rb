module Rails3::Assist::App::Files
  module View
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
  end
end