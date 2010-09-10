module Rails::Assist
  module BaseHelper

    # DELETE
    def remove_artifact name, type
      file = make_file_name name, type
      debug "removed artifact: #{name}" if File.exist?(file) && FileUtils.rm_f(file) 
    end

    def remove_artifacts type,*names
      names.flatten.each{|name| send :"remove_#{type}", name }
    end
  end
end