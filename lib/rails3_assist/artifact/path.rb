require 'rails3_assist/directory'

module Rails3::Assist::Artifact
  module Path
    include Rails3::Assist::Artifact::Directory    
    
    def artifact_path name, type, options={}
      dir = send :"#{type}_dir", options
      File.join(dir, "#{name}#{type_postfix type}.rb")
    end

    protected

    def type_postfix type
      "_#{type}" if ![:model].include?(type)
    end
  end
end