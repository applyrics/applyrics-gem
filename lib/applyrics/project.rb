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

    # Return a list of detected languages in the project
    def detected_languages
      @project.detected_languages()
    end

    def platform_project_settings(name)
      @project.platform_project_settings(name)
    end
  end
end
