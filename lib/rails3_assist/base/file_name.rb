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
          found_file = send finder_method, name 
          return found_file if found_file
          raise "The call to #finder_#{type}(#{name}) didn't find an existing #{type} file"
        end        

        raise "The method #finder_#{type} to find the migration is not available!" if type == :migration          

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
    end
    
    include FileName
  end    
end