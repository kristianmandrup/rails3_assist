module Rails::Assist
  module BaseHelper         
    include Rails::Assist::ArtifactPath

    def make_file_name name, type, options={}      
      send :"#{type}_file_name", name, options
    end

    def existing_file_name name, type 
      # first try finder method
      finder_method = :"find_#{type}"
      found = send finder_method, name if respond_to? finder_method      
      # default
      make_file_name(name, type) if !found
    end
  end
end