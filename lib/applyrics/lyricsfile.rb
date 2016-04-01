module Applyrics
  class Lyricsfile
    class << self
      def exist?
        File.exist?("./Lyricsfile")
      end
      def generate(config=nil)
        template = File.read("#{Gem::Specification.find_by_name('applyrics').gem_dir}/lib/assets/LyricsfileTemplate")

        if config.key?(:account_id)
          template.gsub!('[[ACCOUNT_ID]]', config[:account_id])
        else
          template.gsub!('[[ACCOUNT_ID]]', 'your-account-id')
          template.gsub!('account:', '# account:')
        end

        if config.key?(:project_key)
          template.gsub!('[[PROJECT_KEY]]', config[:project_key])
        else
          template.gsub!('[[PROJECT_KEY]]', 'your-project-key')
          template.gsub!('project:', '# project:')
        end

        if config.key?(:filename)
          template.gsub!('[[FILENAME]]', config[:filename])
        else
          template.gsub!('[[FILENAME]]', 'lyrics.json')
          template.gsub!('filename:', '# filename:')
        end

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
