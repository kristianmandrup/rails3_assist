module Rails3::Assist
  module BaseHelper
    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        include Rails3::Assist::App
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
      Rails3::Assist.debug_on
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

    def marker_option name, type, options={}      
      marker_content = type ? send(:"#{type}_marker", name, options) : name.to_s.camelize
      options[:before] ? {:before => marker_content} : {:after => marker_content}      
    end
  end
end   

require_all File.dirname(__FILE__) + '/base'