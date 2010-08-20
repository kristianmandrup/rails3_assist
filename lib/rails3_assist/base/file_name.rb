module Rails::Assist
  module BaseHelper
    module FileName         
      include Rails::Assist::ArtifactPath

      def make_file_name name, type, options={}      
        send :"#{type}_file_name", name, options
      end

      def existing_file_name name, type=nil 
        # first try finder method
        finder_method = :"find_#{type}"       
        if respond_to?(finder_method)          
          result = send finder_method, name 
          if !result.kind_of? String          
            raise "The call to #find_#{type}(#{name}) didn't find an existing #{type} file. Error in find expression: #{result.find_expr}" 
          end
          return result
        else
          raise "The method #find_#{type} to find the migration is not available!" if type == :migration          
        end
        
        # puts "Using method #make_file_name(#{name}) for #{type || 'unknown'}"

        # default for non-migration
        make_file_name(name, type)      
      end

      Rails::Assist.artifacts.each do |name|
        class_eval %{
          def existing_#{name}_file name, type=nil
            existing_file_name name, type
          end
        } 
      end
    end  # file_name
    
    include FileName
  end    
end