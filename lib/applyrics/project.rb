require 'i18n_data'
require 'applyrics/project_ios'
module Applyrics
  class Project
    class << self
      def is_ios?
        (Dir["*.xcodeproj"] + Dir["*.xcworkspace"]).count > 0
      end

      def is_android?
        Dir["*.gradle"].count > 0
      end

      def is_unity?
        false
      end

      def detected_platform
        if is_ios?
          :ios
        elsif is_android?
          :android
        elsif is_unity?
          :unity
        else
          nil
        end
      end
    end

    def initialize(platform=nil, path="")

      if platform.nil?
        platform = self.class.detected_platform
      end

      @platform = platform

      if @platform == :ios
        @project = Applyrics::Project_iOS.new(path)
      end

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
