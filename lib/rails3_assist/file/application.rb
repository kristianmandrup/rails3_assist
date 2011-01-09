require 'sugar-high/file'
require 'sugar-high/file_mutate'

module Rails3::Assist::File
  module Application
    module Methods
      def insert_application_config statement=nil, &block
        statement = block ? yield : "config.#{statement}"
        File.insert_into application_file, statement, :after => 'Rails::Application'
      end  
    end
    include Methods
    extend Methods
  end
end