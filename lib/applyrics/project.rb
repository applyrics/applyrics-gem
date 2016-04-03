require 'i18n_data'
require 'applyrics/project_ios'
module Applyrics
  class Project
    def initialize(platform, path="")
      @platform = platform

      if @platform == :ios
        @project = Applyrics::Project_iOS.new(path)
      end

      puts path
      @path = path
    end

    # @return [Array] An array of languages detected in the project.
    def detected_languages
      @project.detected_languages()
    end

    # @param [String] the name of the setting to read.
    # @return [String, nil] the value of the setting or nil if not found.
    def platform_project_settings(name)
      @project.platform_project_settings(name)
    end

    # Rebuild the language files.
    def rebuild_files
      @project.rebuild_files()
    end
  end
end
