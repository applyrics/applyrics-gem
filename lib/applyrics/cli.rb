require 'commander'
require 'applyrics/setup'

module Applyrics
  class CLI
    include Commander::Methods

    def self.start
      new.run
    end

    def run
      program :name, 'applyrics'
      program :version, Applyrics::VERSION
      program :description, Applyrics::DESCRIPTION
      program :help_formatter, :compact

      command :init do |c|
        c.syntax = "applyrics init"
        c.description = "Sets up the project"
        c.action do |args, options|
          puts "Not implemented yet... Sorry!"
        end
      end

      command :rebuild do |c|
        c.syntax = "applyrics rebuild"
        c.description = "Rebuilds language files for your project"
        c.option '--project STRING', String, 'Path to iOS or Android project'
        c.action do |args, options|
          options.default :project => './'
          puts "rebuilding..."
          project = Applyrics::Project.new()
          project.rebuild_files()
        end
      end

      command :apply do |c|
        c.syntax = "applyrics apply"
        c.description = "Applies language from a .json file"
        c.option '--project STRING', String, 'Path to iOS or Android project'
        c.option '--data STRING', String, 'Path to .json file (Default: lyrics.json)'
        c.action do |args, options|
          options.default :project => './', :data => './lyrics.json'
          puts "Not implemented yet... Sorry!"
        end
      end

      run!
    end
  end
end
