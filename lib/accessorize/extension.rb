module Accessorize
  module Extension
    @@meta = nil
    @@accessor = nil
    
    def self.included(base)
      base.before_filter :set_extension_points
    end
   
    def self.meta
      @@meta.respond_to?(:call) ? @@meta.call : @@meta
    end
   
    def self.accessor
      @@accessor.respond_to?(:call) ? @@accessor.call : @@accessor
    end
   
    def self.meta=(value)
      @@meta = value
    end
   
    def self.accessor=(value)
      @@accessor = value
    end
   
    private
   
    def set_extension_points
      @@meta = lambda { self.send(Accessorize::Config.meta) rescue nil }
      @@accessor = lambda { self.send(Accessorize::Config.accessor).id rescue nil }
    end
  end
end

 
ActionController::Base.send :include, Accessorize::Extension