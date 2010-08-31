module Rails3::Assist::Artifact
  module Files
    def self.rails_artifacts
      @rails_artifacts ||= begin
        methods = Rails3::Assist::Artifact::Files.instance_methods
        # files_methods = methods.grep(/_files$/)
        # files_methods.map{|dir| dir.gsub(/^(.*)_dir/, '\1').to_sym }
      end      
    end

    def self.valid_artifact? type
      rails_artifacts.include?(type)
    end

    [:model, :controller, :helper].each do |name|
      class_eval %{
        def #{name}_files expr=nil
          files = rails_app_files(:#{name.to_s.pluralize}).grep expr
          yield files if block_given?      
        end          
      }
    end

    # artifact files using xxx_[artifact].rb convention, i.e postfixing with type of artifact
    [:mailer, :observer, :permit].each do |name|
      class_eval %{
        def #{name}_files expr=nil
          files = rails_app_files(:#{name.to_s.pluralize}, '**/*_#{name}.rb').grep expr
          yield files if block_given?
        end  
      }
    end
  end
end