module Rails::Assist
  module View
    include Rails::Assist::BaseHelper
    
    # CREATE
    def create_view name, *args, &block
      action, type, args = get_view_args(args)
      file = view_file_name(name, action, type)
      dir = File.dirname(file)
      FileUtils.mkdir_p dir if !File.directory?(dir)

      content = get_content(args) || yield if block
      
      # abort if no content given
      debug "Warning: Content must be passed in either as a :content hash or a block" if !content
      return nil if !content

      debug "Writing view file: #{file}"      
      # write file content of view
      File.open(file, 'w') do |f|  
        f.puts content 
      end
    end  

    # READ
    def read_view(name, *args, &block)
      action, type, args = get_view_args(args)      
      file_name = view_file_name(name, action, type)
      debug "reading from: #{file_name}"
      file = File.new(file_name)
      raise "The view file: #{file} could not be found" if !file
      begin
        content = file.read
        debug "read content: #{content}"
        yield content if block
        content
      rescue
        nil
      end
    end
    

    # UPDATE
    def insert_into_view(name, *args, &block)
      action, type, args = get_view_args(args)
      file = view_file_name(name, action, type)
      debug "file insertion (view): #{file}"
      
      options = args.first.kind_of?(Hash) ? args.first : {}      
      marker = options[:before] || options[:after]

      raise ArgumentError, ":before or :after option must be specified for insertion" if !marker      
      file_insertion(file, marker, options, &block)
    end

    # DELETE
    def remove_view name, action=nil, type=nil
      file = view_file_name(name, action, type)
      FileUtils.rm_f(file) if File.exist?(file)
    end

    def get_content args
      args = args.flatten
      case args.first
      when Hash
        args.first[:content]
      end
    end

    def get_view_args args 
      args = args.flatten
      case args.first
      when Hash
        action = args.first.delete(:action)
        type = args.first.delete(:type)
      when String, Symbol
        action = args.delete_at(0)
      end
      case args.first
      when String, Symbol        
        type = args.delete_at(0)
      end      
      [action, type, args]
    end


    def get_action action
      (action || 'show').to_s
    end

    def get_type type
      type || 'html.erb'
    end
    
    include FileName

    aliases_for :view 
  end
end