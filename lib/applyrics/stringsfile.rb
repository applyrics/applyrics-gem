# encoding=utf-8
module Applyrics
  class StringsFile

    def initialize(path, data=nil)
      @path = path
      @hash = data
      if data.nil?
        read
      end
    end

    def read
      @hash = {}
      parser = Parser.new(@hash)
      File.open(@path, 'rb:bom|utf-16LE:utf-8') { |fd| parser.parse fd }
      self
    end

    def keys
      # Not implemented...
    end

    def have_key?
      # Not implemented...
    end

    def string_for_key(key)
      # Not implemented...
    end

    def to_hash
      @hash
    end

    class Parser
      def initialize(hash)
        @hash = hash
        @property_regex = %r/\A(.*?)=(.*)\z/u
        @quote          = %r/"([^"]+)"/u
        @open_quote     = %r/\A\s*(".*)\z/u
        @comment_regex  = %r/\/\*([^*]+)\*\//u
      end

      def parse(data)
        @hash.clear
        data.each_line do |line|
          @line = line.chomp

          case @line
          when @comment_regex
            # Not implemented
          when @property_regex
            key = strip($1)
            value = strip($2)
            @hash[key] = value
          end
        end

        @hash
      end

      def strip(value)
        str = @quote.match(value.strip)
        if str.nil?
          value.strip
        else
          str[1]
        end
      end
    end
  end
end
