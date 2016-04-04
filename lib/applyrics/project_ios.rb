require 'i18n_data'
require 'applyrics/tools/genstrings'
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
      @langs = {}
    end

    # Return a list of detected languages in the project
    def detected_languages
      folder = self.platform_project_settings("SOURCE_ROOT")
      base_language = I18nData.language_code(self.platform_project_settings("DEVELOPMENT_LANGUAGE")).downcase
      lang_folders = Dir.glob(File.join(folder, "**", "*.lproj"))
      lang_folders.each do |lang_folder|
        lang = /([A-Za-z\-]*?)\.lproj/.match(lang_folder)[1]
        lang = (lang == "Base" ? base_language : lang)
        @langs[lang] = lang_folder
      end
      return @langs
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

    def rebuild_files
      folder = self.platform_project_settings("SOURCE_ROOT")
      tmp_folder = "./.tmp/"

      if !Dir.exist?(tmp_folder)
        Dir.mkdir(tmp_folder, 0700)
      end

      puts tmp_folder

      Applyrics::GenStrings.run("#{folder}", tmp_folder)
    end
  end
end
