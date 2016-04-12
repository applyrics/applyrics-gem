# encoding: utf-8
require 'i18n_data'
require 'multi_json'
require 'fileutils'
require 'applyrics/tools/genstrings'
require 'applyrics/tools/ibtool'
require 'applyrics/stringsfile'
module Applyrics
  class Project_iOS
    def initialize(path)
      if path.to_s.length == 0
        path = Dir["./*.xcworkspace"].first
      end
      if path.to_s.length == 0
        path = Dir["./*.xcodeproj"].first
      end
      @path = path
      @platform_settings = nil
      @langs = []
      @default_language = nil
    end

    # Return a list of detected languages in the project
    def detected_languages
      @langs = []
      folder = self.platform_project_settings("SOURCE_ROOT")
      lang_folders = Dir.glob(File.join(folder, "**", "*.lproj"))
      lang_folders.each do |lang_folder|
        lang = /([A-Za-z\-]*?)\.lproj/.match(lang_folder)[1]
        lang = (lang == "Base" ? default_language : lang)
        @langs << lang
      end
      return @langs
    end

    def language_files
      folder = self.platform_project_settings("SOURCE_ROOT") unless !folder.nil?
      out = {}
      Dir[File.join(folder, "**", "*.lproj", "*.strings")].each do |file|
        lang = /(\w*).lproj/.match(file)[1]
        lang = (lang == "Base" ? default_language : lang)

        if !out.key?(lang)
          out[lang] = []
        end

        out[lang] << file
      end

      out
    end

    def default_language
      if @default_language.nil?
        @default_language = I18nData.language_code(self.platform_project_settings("DEVELOPMENT_LANGUAGE")).downcase
      end
      @default_language
    end

    def platform_project_settings(name)
      if @platform_settings.nil?
        cmd = ["set -o pipefail && xcrun xcodebuild -showBuildSettings"]
        cmd << "-project '#{@path}'"
        @platform_settings = Command.execute(cmd, false)
      end

      result = @platform_settings.split("\n").find { |c| c.split(" = ").first.strip == name }
      return result.split(" = ").last
    end

    def string_files(folder=nil)
      folder = self.platform_project_settings("SOURCE_ROOT") unless !folder.nil?

      out = {}

      Dir[File.join(folder, "**", "*.lproj", "*.strings")].each do |file|
        strings = StringsFile.new(file)
        lang = /(\w*).lproj/.match(file)[1]
        lang = (lang == "Base" ? default_language : lang)

        if !out.key?(lang)
          out[lang] = {}
        end

        out[lang][File.basename(file)] = strings.to_hash
      end

      out
    end

    # NOTE: This will only rebuild the base language
    def rebuild_files
      folder = self.platform_project_settings("SOURCE_ROOT")
      tmp_folder = "./tmp/"

      if !Dir.exist?(tmp_folder)
        Dir.mkdir(tmp_folder, 0700)
      end

      GenStrings.run("#{folder}", tmp_folder)
      IBTool.run("#{folder}", tmp_folder)

      lang = default_language
      out = {"#{lang}" => {}}
      langHash = out["#{lang}"]

      Dir[File.join(tmp_folder, "*.strings")].each do |file|
        strings = StringsFile.new(file)
        langHash[File.basename(file)] = strings.to_hash
      end

      FileUtils.remove_dir(tmp_folder)

      out
    end

    def apply_languages(data)
      folder = self.platform_project_settings("SOURCE_ROOT")

      data.each do |lang, files|
        files.each do |file, data|

          lang_folder = Dir[File.join(folder, "**", (lang == default_language ? "Base" : lang) + ".lproj")].first

          if !Dir.exist?(lang_folder)
            Dir.mkdir(lang_folder, 0700)
            puts "Created #{lang_folder}".yellow
          end

          strings = StringsFile.new(File.join(lang_folder, file), data)
          strings.write
        end
      end
    end
  end
end
