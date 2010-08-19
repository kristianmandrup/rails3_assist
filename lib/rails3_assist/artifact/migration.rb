require 'migration_assist'

Rails::Migration::Assist.root_dir = Rails::Assist::Migration.root_dir

module Rails::Assist
  module Migration
    include Rails::Assist::BaseHelper    
    include Rails::Migration::Assist::ClassMethods

    include FileName
    
    def find_migration name, option=nil
      migrations = Dir.glob("#{migration_dir}/[0-9]*_*.rb")
      return nil if !migrations.empty?      
      matching_migrations = migrations.grep(/\d+_#{name}\.rb$/)
      return nil if matching_migrations.empty?
      migration_file = (option == :last) ? matching_migrations.last : matching_migrations.first
    end

    def migration_marker name, options=nil
      "#{name.to_s.camelize} < ActiveRecord::Migration"
    end    
  end
end