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
        found_file = send finder_method, name if respond_to?(finder_method)
        return found_file if found_file
        # default
        make_file_name(name, type)      
      end
    end
    
    include FileName
  end    
end