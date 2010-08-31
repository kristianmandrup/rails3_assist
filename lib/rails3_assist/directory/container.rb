module Rails3::Assist::Directory      
  module Container  
    # return list of symbols for all kinds of supported Rails 3 containers 
    # (those that have a [container]_dir method)
    def self.rails_containers
      app_methods       = Rails3::Assist::Directory.instance_methods
      artifact_methods  = Rails3::Assist::Artifact::Directory.instance_methods
      all_methods = app_methods + artifact_methods
    
      all_methods.grep(/_dir$/).map{|dir| dir.to_s.gsub(/^(.*)_dir/, '\1').to_sym }
    end

    def self.valid_container? type
      rails_containers.include?(type)
    end
  end
end
