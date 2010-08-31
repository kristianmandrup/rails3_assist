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
end  

require_all File.dirname(__FILE__) + '/artifact'