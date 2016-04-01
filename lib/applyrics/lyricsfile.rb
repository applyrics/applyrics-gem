module Applyrics
  class Lyricsfile
    class << self
      def exist?
        File.exist?("./Lyricsfile")
      end
      def generate
        template = File.read("#{Gem::Specification.find_by_name('applyrics').gem_dir}/lib/assets/LyricsfileTemplate")
        File.write("./Lyricsfile", template)
      end
    end

    def initialize(path=nil)
      @path = File.expand_path(path)
      parse(File.read(@path))
    end
    def parse_binding
      binding
    end
    def parse(data)
      begin
         eval(data, parse_binding)
       rescue SyntaxError => ex
       end
    end
  end
end
