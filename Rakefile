task :default => :test

task :format do
  begin
    require 'rubocop/rake_task'
    RuboCop::RakeTask.new(:format)
  rescue LoadError
    puts 'Format check failed!'
  end
end

task :spec do
  begin
    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new(:spec)
  rescue LoadError
    puts 'Spec check failed!'
  end
end

task :test do
  Rake::Task[:spec].invoke
  Rake::Task[:format].invoke
end
