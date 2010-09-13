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
  
  class << self
    attr_accessor :debug_on
  end
end

require 'rails3_assist/app'
require 'rails3_assist/directory'
require 'rails3_assist/file'
require 'rails3_assist/files'
require 'rails3_assist/artifact'

require 'rails3_assist/rspec/configure'

