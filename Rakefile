require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "accessorize"
    gem.summary = %Q{Log all data access for your ActiveRecord models}
    gem.description = %Q{Sometimes you need to keep rigid logs of who created, updated and even accessed the data in your database. Accessorize simplifies the process.}
    gem.email = "jeff@socialrange.org"
    gem.homepage = "http://github.com/jeffrafter/accessorize"
    gem.authors = ["Jeff Rafter"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.files = FileList["[A-Z]*", "{generators,lib,rails}/**/*", "test/accessorize_test.rb"] 
    gem.test_files = FileList["test/accessorize_test.rb"] 
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test => ["generator:cleanup", "generator:accessorize"]) do |task|
  task.libs << "lib" << "test" << "test/rails/test"
  task.pattern = "test/**/*_test.rb"
  task.verbose = true
end  

namespace :test do
  Rake::TestTask.new(:database => ["generator:cleanup", "generator:database", "generator:accessorize"]) do |task|
    task.libs << "lib" << "test"
    task.pattern = "test/**/*_test.rb"
    task.verbose = true
  end  
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

generators = %w(accessorize)

namespace :generator do
  desc "Cleans up the test app before running the generator"
  task :cleanup do  
    FileUtils.rm_rf("test/rails")
    system "cd test && rails rails"

    # I don't like testing performance!
    FileUtils.rm_rf("test/rails/test/performance")

    system "echo \"\" >> test/rails/config/environments/test.rb"
    system "echo \"config.gem 'thoughtbot-shoulda', :lib => 'shoulda'\" >> test/rails/config/environments/test.rb"
    system "echo \"config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl'\" >> test/rails/config/environments/test.rb"

    # Make a thing
    system "cd test/rails && ./script/generate scaffold thing name:string mood:string"

    FileUtils.mkdir_p("test/rails/vendor/plugins")
    accessorize_root = File.expand_path(File.dirname(__FILE__))
    system("ln -s #{accessorize_root} test/rails/vendor/plugins/accessorize")
  end
  
  desc "Prepares the application with an alternate database" 
  task :database do
    puts "==  Configuring the database =================================================="
    system "cp config/database.yml.sample test/rails/config/database.yml"
    system "cd test/rails && rake db:migrate:reset"
  end

  desc "Run the accessorize generator"
  task :accessorize do
    system "cd test/rails && ./script/generate accessorize && rake db:migrate db:test:prepare"
  end
  
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "accessorize #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
