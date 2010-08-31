module Rails3::Assist::Artifact
  def self.helper_list
    self.artifacts + [:view]
  end

  def self.app_artifacts
    [:controller, :mailer, :helper, :view, :model, :permit]
  end

  def app_artifacts
    Rails3::Assist::Artifact.app_artifacts
  end
  
  def self.rails_artifacts
    @rails_artifacts ||= begin
      files_methods = Rails3::Assist::Artifact::Files.instance_methods        
      files_symbols = files_methods.grep(/_files$/).map{|f| f.to_s.gsub(/^(.*)_files/, '\1').to_sym }

      # dir_methods = Rails3::Assist::Artifact::Directory.instance_methods        
      # dir_symbols = dir_methods.map{|dir| dir.to_s.gsub(/^(.*)_dir/, '\1').to_sym }
      dir_symbols = []
      
      (files_symbols + dir_symbols).uniq
    end      
  end

  def self.valid_artifact? type
    rails_artifacts.include?(type)
  end
  
end  

require_all File.dirname(__FILE__) + '/artifact'