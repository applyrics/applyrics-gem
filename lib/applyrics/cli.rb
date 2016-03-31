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
          Applyrics::Setup.new.run()
          if agree("Rebuild language files?")
            puts "will rebuild..."
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

      run!
    end
  end
end
