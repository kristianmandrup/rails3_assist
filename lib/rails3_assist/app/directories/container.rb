module Rails::Assist::Directories
  module Containers      
    # return list of symbols for all kinds of supported Rails 3 containers (those that have a [container]_dir method)
    def self.rails_containers
      Rails::Assist::App::RailsDirs.instance_methods.grep(/_dir$/).map{|dir| dir.gsub(/^(.*)_dir/, '\1').to_sym }
    end

    def self.valid_container? type
      rails_containers.include?(type)
    end
  end
end