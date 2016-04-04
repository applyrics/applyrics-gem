# encoding=utf-8
module Applyrics
  class StringsFile

    def initialize(filename, data=nil)
      @filename = filename
      @hash = data.nil? ? {} : data
      if data.nil?
        read
      end
    end

    def read
      @hash = {}
      parser = Parser.new(@hash)
      File.open(@filename, 'rb:utf-16LE:utf-8') { |fd| parser.parse fd }
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

    def hash
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
        found_bad_bytes = false
        data.each_line do |line|
          @line = line.chomp
          if !found_bad_bytes
            first_bytes = @line[0..1].bytes.to_a
            if first_bytes.length == 2 && first_bytes[0] == 255
              @line = @line[2,@line.length].force_encoding('UTF-8')
              found_bad_bytes = true
            end
          end

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