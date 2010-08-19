module Rails::Assist
  module View
    include Rails::Assist::BaseHelper
    
    # CREATE
    def create_view name, options = {}, &block
      file = view_file_name(name, options[:action], options[:type])
      dir = File.dirname(file)
      FileUtils.mkdir_p dir if !File.directory?(dir)
      content = options[:content]
      # set content to block
      content ||= yield if block

      # abort if no content given
      return if !content    
      
      # write file content of view
      File.open(file, 'w') do |f|  
        f.puts content 
      end
    end  

    # READ
    def read_view(name, options = {}, &block)
      file_name = view_file_name(name, options[:action], options[:type])
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
    def insert_into_view(name, options = {}, &block)
      debug "insert_into_view: #{options}"
      file = view_file_name(name, options[:action], options[:type])
      debug "file insertion (view): #{file}"
      marker = options[:before] || options[:after]
      file_insertion(file, marker, options, &block) if marker
    end

    # DELETE
    def remove_view name, action=nil, type=nil
      file = view_file_name(name, action, type)
      FileUtils.rm_f(file) if File.exist?(file)
    end

    def get_action action
      action || 'show'
    end

    def get_type type
      type || 'html.erb'
    end
    
    include FileName

    aliases_for :view 
  end
end