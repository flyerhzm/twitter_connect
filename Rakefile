require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'jeweler'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the twitter_connect plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the twitter_connect plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'TwitterConnect'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Jeweler::Tasks.new do |gemspec|
  gemspec.name = "twitter_connect"
  gemspec.summary = "facebook connect style twitter oauth"
  gemspec.description = "facebook connect style twitter oauth"
  gemspec.email = "flyerhzm@gmail.com"
  gemspec.homepage = "http://github.com/flyerhzm/twitter_connect"
  gemspec.authors = ["Richard Huang"]
  gemspec.files.exclude '.gitignore'
  gemspec.add_dependency 'twitter'
end
Jeweler::GemcutterTasks.new
