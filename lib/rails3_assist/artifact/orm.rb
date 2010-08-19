module Rails::Assist
  module Orm
    module Base
      include Rails::Assist::Model 

      protected

      def orm_marker_name options = {:model_type => :document}
        document_name options
      end

      def document_name options = {:model_type => :document} 
        type_content = options[:model_type] == :embedded ?  "#{orm_name}::EmbeddedDocument" : "#{orm_name}::Document"
      end

      def clazz name
        "class #{name.to_s.camelize}"
      end

      def file name, include_stmt, &block
        %Q{#{clazz name}
  #{include_stmt}
  #{yield if block}
end}
      end

      def file_w_include name, module_name, &block
        file name, "include #{module_name}", &block 
      end

      def simple_file name, module_name, &block
        %Q{#{clazz name}
  #{yield if block}
end}
      end

      def file_w_inherit name, module_name, &block
        %Q{#{clazz name} < #{module_name}
  #{yield if block}
end}
      end 
      
      def field name, type = nil
        return "#{field_name} :#{name}, #{type}" if type
        "#{field_name} :#{name}"
      end      
    end

    module None
      include Rails::Assist::Orm::Base

      def orm_marker_name options=nil
        @name
      end

      def new_model_content name, options={}, &block        
        content = options[:content] || yield if block
        @name = name
        simple_file(name, orm_marker_name(options)) { content }
      end
    end

    module ActiveRecord
      include Rails::Assist::Orm::Base

      def orm_marker_name options=nil
        'ActiveRecord::Base'
      end

      def new_model_content name, options={}, &block        
        content = options[:content] || yield if block
        file_w_inherit(name, orm_marker_name(options)) { content }
      end
    end

    module MongoMapper
      include Rails::Assist::Orm::Base

      def orm_name
        'MongoMapper'
      end      
      
      def new_model_content name, options={}, &block        
        content = options[:content] || yield if block
        file_w_include(name, orm_marker_name(options)) { content }
      end

      def field_name
        'key'
      end
    end

    module Mongoid
      include Rails::Assist::Orm::Base

      def orm_name
        'Mongoid'
      end

      def field_name
        'field'
      end

      def new_model_content name, options={}, &block        
        content = options[:content] || yield if block
        file_w_include(name, orm_marker_name(options)) { content }
      end

      def field name, type = nil
        return "#{field_name} :#{name}, :type => #{type}" if type
        "#{field_name} :#{name}"
      end
    end

    module DataMapper
      include Rails::Assist::Orm::Base

      def orm_name
        'DataMapper'
      end

      def orm_marker_name options=nil
        "#{orm_name}::Resource"
      end

      def new_model_content name, options={}, &block        
        content = options[:content] || yield if block
        file_w_include(name, orm_marker_name(options)) { content }
      end

      def field_name
        'property'
      end
    end
  end
end
