module Rails::Assist
  module BaseHelper         
    # UPDATE
    def insert_content(name, options={}, &block)
      type = get_type(options)
      file = existing_file_name(name, type)  
      x_marker = marker(name, type, options)
      res = file_insertion file, x_marker, options, &block
      if !res
        # try with :embedded option if default doesn't work
        x2_marker = marker(name, type, options.merge(:model_type => :embedded))
        file_insertion file, x2_marker, options, &block        
      end
    end

    protected

    def file_insertion(file_name, marker, options={}, &block)
      return nil if !marker

      file = File.new(file_name)
      return nil if !File.exist?(file)

      insert_content = options[:content] || (yield if block)

      # already inserted?
      return nil if insert_content.blank? || (file.read =~ /#{insert_content}/)

      place = options[:before] ? :before : :after 

      debug "insert #{place}: '#{marker}'"
      debug "content: #{insert_content}"
      
      return nil if !(File.new(file.path).read =~ /#{Regexp.escape(marker)}/)
      
      mutate_file file.path, marker, place do
         insert_content
       end
     end   

     def mutate_file file, marker, place, &block
       raise ArgumentError, "You must define a replacement marker for a :before or :after key" if !marker 
       replace_in_file file, /(#{Regexp.escape(marker)})/mi do |match|
         place == :after ? "#{match}\n  #{yield}" : "#{yield}\n  #{match}"         
       end
     end  
     
     def replace_in_file(path, regexp, *args, &block)
       content = File.read(path).gsub(regexp, *args, &block)
       File.open(path, 'wb') { |file| file.write(content) }
     end    
  end
end