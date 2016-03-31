require 'i18n_data'
module Applyrics
  class Project
    def initialize(platform, path="")
      @platform = platform

      if path.to_s.length == 0
        path = Dir["./*.xcworkspace"].first
      end
      if path.to_s.length == 0
        path = Dir["./*.xcodeproj"].first
      end

      puts "Path:"
      puts path
      @path = path
    end

    # Return a list of detected languages in the project
    def detected_languages
      if @platform == :ios
        folder = self.platform_project_settings("SOURCE_ROOT")
        base_language = I18nData.language_code(self.platform_project_settings("DEVELOPMENT_LANGUAGE")).downcase
        lang_folders = Dir.glob(File.join(folder, "**", "*.lproj"))
        @langs = {}
        lang_folders.each do |lang_folder|
          lang = /([A-Za-z\-]*?)\.lproj/.match(lang_folder)[1]
          lang = (lang == "Base" ? base_language : lang)
          @langs[lang] = lang_folder
        end

      elsif @platform == :android

      end
    end

    def platform_project_settings(name)
      if @platform == :ios
        if @platform_settings.nil?
          cmd = ["set -o pipefail && xcrun xcodebuild -showBuildSettings"]
          cmd << "-project '#{@path}'"
          @platform_settings = Command.execute(cmd, false)
        end

        result = @platform_settings.split("\n").find { |c| c.split(" = ").first.strip == name }
        return result.split(" = ").last
      end
    end

    def to_s
      "Project at #{@path}"
    end
  end
end
