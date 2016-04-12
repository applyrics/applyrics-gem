require 'commander'
require 'colored'
require 'applyrics/setup'
require 'applyrics/languagefile'

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
      global_option '--[no-]rebuild', TrueClass, 'Rebuild language files from source'

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

      command :extract do |c|
        c.syntax = "applyrics extract"
        c.description = "Pull strings from the project into a strings.json file"
        c.action do |args, options|
          
          project = Applyrics::Project.new()
          detect_lang = project.detected_languages

          langs = project.string_files()

          puts "Found files for #{langs.length} languages".green

          if options.rebuild
            puts "Rebuilding...".blue
            rebuilt = project.rebuild_files()
            langs = langs.merge(rebuilt)
            puts "Language \"#{project.default_language}\" is rebuilt from source into #{rebuilt[project.default_language].length} files".blue
          end

          puts "Writing #{langs.length} languages: #{langs.keys.join(', ')}".green

          file = LanguageFile.new(File.join("./", "strings.json"), langs)
          file.write

        end
      end

      command :apply do |c|
        c.syntax = "applyrics apply"
        c.description = "Applies language from a .json file"
        c.option '--data STRING', String, 'Path to .json file (Default: strings.json)'
        c.action do |args, options|
          options.default :project => './', :data => './strings.json'

          language_file = LanguageFile.new(options.data)

          puts "Loaded language file with #{language_file.languages.length} languages".green

          project = Applyrics::Project.new()
          detect_lang = project.detected_languages

          langs = project.string_files()

          langs = langs.merge(language_file.to_hash)

          project.apply_languages(langs)


        end
      end

      run!
    end
  end
end
