require 'applyrics/project'
module Applyrics
  class Setup

    def run()
      platform = nil
      if is_ios?
        puts "Found iOS project..."
        platform = :ios
      elsif is_android?
        puts "Found Android project..."
        platform = :android
      elsif is_unity?
        puts "Found Unity project..."
        platform = :unity
      else
        puts "Didn't find any project!"
        return
      end

      project = Applyrics::Project.new(platform)
      project.detected_languages()
    end

    def is_ios?
      (Dir["*.xcodeproj"] + Dir["*.xcworkspace"]).count > 0
    end

    def is_android?
      Dir["*.gradle"].count > 0
    end

    def is_unity?
      false
    end
  end
end
