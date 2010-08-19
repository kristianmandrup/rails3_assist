module Rails::Assist
  (artifacts - [:migration, :model]).each do |name|
    class_eval %{
      module #{name.to_s.camelize}
        def new_#{name}_content name, content=nil, &block
          new_artifact_content name, :#{name}, content, &block
        end
      end
    }
  end    
end    
