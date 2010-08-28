module Rails::Assist::App::Files
  module Helpers
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
end