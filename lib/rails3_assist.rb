require 'thor'
require 'require_all'
require 'fileutils'
require 'rake'
require 'active_support/inflector'

require 'sugar-high/alias'
require 'sugar-high/file'
require 'sugar-high/regexp'

require 'rails3_assist/namespaces'

module Rails3::Assist
  def self.artifacts
    [:observer, :controller, :helper, :mailer, :model, :migration, :permit]
  end

  def self.specials type=nil
    case type
    when :config
      [:initializer, :locale]
    when :public
      [:stylesheet, :javascript]
    else
      raise ArgumentError, "Unknown specials type #{type}. Specify :config or :public" if type && type != :all
      [:initializer, :locale] + [:stylesheet, :javascript]
    end
  end
  
  class << self
    attr_accessor :debug_on
  end
end

require 'rails3_assist/app'
require 'rails3_assist/directory'
require 'rails3_assist/file'
require 'rails3_assist/files'
require 'rails3_assist/artifact'


