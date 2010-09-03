require 'rails3_assist/files'

module Rails3::Assist::Artifact
  module Files  
    include Rails3::Assist::Files

    module Methods
      [:model].each do |name|
        class_eval %{
          def #{name}_files expr=nil
            files = Rails3::Assist::Files.rails_app_files(:#{name.to_s.pluralize})
            files = files.grep(expr) if expr
            yield files if block_given?
            files
          end          
        }
      end

      # artifact files using xxx_[artifact].rb convention, i.e postfixing with type of artifact
      [:mailer, :observer, :permit, :controller, :helper].each do |name|
        class_eval %{
          def #{name}_files expr=nil
            files = Rails3::Assist::Files.rails_app_files(:#{name.to_s.pluralize}, :pattern => '**/*_#{name}.rb')
            files = files.grep(expr) if expr
            yield files if block_given?
            files
          end  
        }
      end   
    end
    
    include Methods
    extend Methods
  end
end