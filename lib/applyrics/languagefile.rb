require 'multi_json'

# encoding=utf-8
module Applyrics
  class LanguageFile

    def initialize(path, data=nil)
      @path = path
      @hash = data
      if data.nil?
        read
      end
    end

    def [](key)
      @hash[key]
    end

    def []=(key, value)
      @hash[key] = value
    end

    def language?(key)
      @hash.key?(key)
    end

    def languages
      @hash.keys
    end

    def read
      @hash = {}
      data = File.read(@path)
      @hash = MultiJson.load(data)
    end

    def write()
      File.open(@path, 'w') { |file| file.write(MultiJson.dump(@hash, :pretty => true)) }
    end

  end
end
