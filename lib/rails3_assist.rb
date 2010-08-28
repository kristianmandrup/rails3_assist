require 'thor'
require 'require_all'
require 'active_support/inflector'
require 'sugar-high/alias'

module Rails
  module Assist
    def self.artifacts
      [:observer, :controller, :helper, :mailer, :model, :migration, :permit]
    end  
    
    class << self
      attr_accessor :debug_on
    end    
  end
end

require 'rails3_assist/extensions/core_ext'
require 'rails3_assist/rspec/macro'
require 'rails3_assist/app'
require_all File.dirname(__FILE__) + '/rails3_assist/artifact'

