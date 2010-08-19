module Rails::Assist
  module BaseHelper
    module ClassMethods
      def aliases_for name
        multi_alias name, 
                    :create => :new, :insert_into => [:inject_into, :update], :read => :X_content, :remove => :delete, 
                    :options => :after
      end
    end
  end
end