require 'commander'
require 'colored'
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
        c.description = "Setup the project for applyrics"
        c.action do |args, options|
          project = Applyrics::Project.new()

          if project.nil?
            puts "Error"
          else
            case project.platform
            when :ios
              puts "Located ".green + "iOS".bold.green + " project".green
            when :android
              puts "Located ".green + "Android".bold.green + " project".green
            end

            langs = project.detected_languages
            puts "Found #{langs.length} languages: #{langs.join(', ')}".green
            puts ""

            lang_files = project.language_files
            langs.each do |lang|
              if !lang_files.key?(lang)
                puts "[#{lang}] No files detected for language!".yellow
                next
              end
            end

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
          project = Applyrics::Project.new()
          project.rebuild_files()
        end
      end

      command :apply do |c|
        c.syntax = "applyrics apply"
        c.description = "Applies language from a .json file"
        c.option '--data STRING', String, 'Path to .json file (Default: strings.json)'
        c.action do |args, options|
          options.default :project => './', :data => './lyrics.json'
          puts "Not implemented yet... Sorry!"
        end
      end

      run!
    end
  end
end
