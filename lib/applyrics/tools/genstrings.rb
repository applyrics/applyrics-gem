require 'applyrics/command'
module Applyrics
  class GenStrings
    class << self
      def run(folder, output_folder=nil)

        output_folder = folder if output_folder.nil?

        folder = File.expand_path(folder)
        output_folder = File.expand_path(output_folder)

        cmd = ["set -o pipefail &&"]
        cmd << Command.which("genstrings")
        cmd << "-o " + Shellwords.escape("#{output_folder}")
        cmd << Shellwords.join(files(folder))

        puts Command.execute(cmd)
      end

      def files(folder)
        return Dir.glob(File.join(folder, "**", "*.{m,swift}"))
      end
    end
  end
end
