class AccessorizeGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'migration.rb', File.join('db', 'migrate'), :migration_file_name => 'create_accessors' 
      m.directory File.join('config', 'initializers')
      m.template 'initializer.rb', File.join('config', 'initializers', 'accessorize.rb')
    end
  end
end