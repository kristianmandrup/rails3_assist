require 'thor'
require 'require_all'
require 'active_support/inflector'
require 'sugar-high/alias'
require 'rails3_assist/namespaces'

module Rails3::Assist
  def self.artifacts
    [:observer, :controller, :helper, :mailer, :model, :migration, :permit]
  end  
  
  class << self
    attr_accessor :debug_on
  end
end

require 'rails3_assist/rspec/macro'
require 'rails3_assist/app'


