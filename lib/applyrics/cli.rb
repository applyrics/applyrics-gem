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

          config = {}
          if agree("Connect to Applyrics.io?")
            ask("Username:")
            ask("Password:  ") { |q| q.echo = "*" }
            choice = choose("Project?", :first, :second, :third)
            config[:account_id] = "awesome-account"
            config[:project_key] = choice.to_s
          elsif agree("Use local files?")
            config[:filename] = "lyrics.json"
          end

          project = Applyrics::Setup.new.run(config)

          if agree("Rebuild language files?")
            puts "will rebuild..."
            project.rebuild_files()
          end
        end
      end

      command :rebuild do |c|
        c.syntax = "applyrics rebuild"
        c.description = "Rebuilds language files for your project"
        c.option '--project STRING', String, 'Path to iOS or Android project'
        c.action do |args, options|
          options.default :project => './'
          puts "rebuilding..."
          Applyrics::GenStrings.run("#{options.project}", "#{options.project}")
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

      command :sync do |c|
        c.syntax = "applyrics sync"
        c.description = "Syncs language from applyrics.io"
        c.option '--project STRING', String, 'Path to iOS or Android project'
        c.action do |args, options|
          options.default :project => './'
          puts "Not implemented yet... Sorry!"
        end
      end

      run!
    end
  end
end
