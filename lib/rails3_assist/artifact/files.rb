require 'rails3_assist/files'

module Rails3::Assist::Artifact
  module Files  
    include Rails3::Assist::Files
    
    [:model].each do |name|
      class_eval %{
        def #{name}_files expr=nil
          files = rails_app_files :#{name.to_s.pluralize}
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
          files = rails_app_files(:#{name.to_s.pluralize}, '**/*_#{name}.rb')
          files = files.grep(expr) if expr
          yield files if block_given?
          files
        end  
      }
    end   
  end
end