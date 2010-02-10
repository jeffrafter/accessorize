module Accessorize
  module Base
    def self.included(base)
      base.send :extend, ClassMethods
    end
    
    module ClassMethods
      def accessorize
        send :include, InstanceMethods
        has_many :accessors, :class_name => 'Accessorize::Accessor', :foreign_key => :reference_id, :conditions => {:reference_type => self.class_name.tableize}
        after_create :create_access
        after_update :update_access
        after_destroy :destroy_access        
      end
    end
    
    module InstanceMethods
      def create_access
        create_accessor('create')
      end

      def update_access
        create_accessor('update')
      end

      def destroy_access
        create_accessor('destroy')
      end
      
      # This method is a performance killer and we are not expecting the base
      # model to define it. If it is defined, this will replace it. In general
      # if you want to define an additional after_find, call accessorize, then
      # alias_method_chain the after_find.
      def after_find
        create_accessor('view')
      end
      
      def create_accessor(event)
        accessors.create(:event => event,
          :reference_type => self.class.name.tableize,
          :accessor_id => Accessorize::Extension.accessor,
          :meta => Accessorize::Extension.meta)
      end
    end
  end
end

ActiveRecord::Base.send :include, Accessorize::Base