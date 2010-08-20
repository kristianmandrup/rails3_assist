module Rails::Assist
  module BaseHelper
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        include Rails::Assist::App
        include ::Thor::Actions
      end
    end
                 
    protected

    def get_type options = {}
      case options
      when Hash
        raise ArgumentError, "No artifact type specified #{options}" if !options[:type]
        options[:type].to_sym
      when String, Symbol
        options.to_sym
      else
        raise ArgumentError, "Bad artifact type specified #{options}"        
      end
    end
    
    def debug?      
      Rails::Assist.debug_on
    end    

    def debug msg
      puts msg if debug?
    end

    def set options, type
      options.merge!(:type => type)
      options
    end

    def orm_notify
      ''
    end

    def marker name, type, options={}      
      return send :"#{type}_marker", name, options if type
      name.to_s.camelize
    end
  end
end   

require_all File.dirname(__FILE__) + '/base'