module Rails::Assist
  module BaseHelper
    def new_artifact_content name, type, content=nil, &block
      content ||= yield if block
      %Q{class #{marker(name, type)}
  #{content}
end}
    end    
             
    # CREATE
    def create_artifact name, options={}, &block
      type = get_type(options)

      file = make_file_name name, type
      return if File.exist?(file)

      debug "create #{type}: #{name}, opt: #{options}"
      debug "file: #{file}"

      # make dir        
      dir = File.dirname(file)
      FileUtils.mkdir_p dir if !File.directory?(dir)

      content = options[:content]
      content ||= yield if block

      content_method = :"new_#{type}_content"
      debug "inner content: #{content}, to inject using ##{content_method}"

      raise "Content method #{content_method} not found #{orm_notify}" if !respond_to?(content_method)

      insert_content = if type == :model        
        send content_method, name, options.merge(:content => content), &block
      else
        send content_method, name, content, &block
      end
      
      debug "content to insert: #{insert_content}"

      return if insert_content.blank?

      File.open(file, 'w') do |f|  
        f.puts insert_content
      end
      debug "file created and content inserted"
    end
  end
end