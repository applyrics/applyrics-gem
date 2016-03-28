require 'commander'

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
          puts "wazzapp!"
          if agree("Rebuild language files?")
            puts "will rebuild..."
          end
        end
      end

      command :rebuild do |c|
        c.syntax = "applyrics rebuild"
        c.description = "Rebuilds language files for your project"
        c.action do |args, options|
          puts "rebuilding..."
          Applyrics::GenStrings.run("./", "./")
        end
      end

      run!
    end
  end
end
