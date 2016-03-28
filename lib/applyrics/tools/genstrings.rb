require 'applyrics/command'
module Applyrics
  class GenStrings
    class << self
      def run(folder, output_folder)
        cmd = []
        cmd << Command.which("genstrings")
        cmd << "-o #{output_folder}"
        cmd << files(folder).join(" ")

        puts cmd.join(" ")
      end

      def files(folder)
        return Dir.glob(File.join(folder, "**", "*.{m,swift}"))
      end
    end
  end
end
