require 'commander'
require 'applyrics/project'
require 'applyrics/lyricsfile'
module Applyrics
  class Setup

    def run(config = {})
      platform = nil
      if is_ios?
        platform = :ios
      elsif is_android?
        platform = :android
      elsif is_unity?
        platform = :unity
      else
        return
      end

      Applyrics::Lyricsfile.generate(config)
      Applyrics::Project.new(platform)
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
