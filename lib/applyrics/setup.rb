require 'commander'
require 'applyrics/project'
require 'applyrics/lyricsfile'
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

      config = {}
      if agree("Connect to Applyrics.io?")
        ask("Username:")
        ask("Password:  ") { |q| q.echo = "*" }
        choice = choose("Project?", :first, :second, :third)
        config[:account_id] = "awesome-account"
        config[:project_key] = choice.to_s
      elsif agree("Use local files?")
        config[:filename] = "lyrics.json"
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
