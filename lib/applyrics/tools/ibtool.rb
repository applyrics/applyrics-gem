# encoding: utf-8
require 'applyrics/command'
module Applyrics
  class IBTool
    class << self
      def run(folder, output_folder=nil)

        output_folder = folder if output_folder.nil?

        folder = File.expand_path(folder)
        output_folder = File.expand_path(output_folder)

        files = files(folder)

        files.each do |file|
          filename = File.basename(file, ".*")
          output_file = File.join(output_folder, filename) + ".strings"
          cmd = ["set -o pipefail &&"]
          cmd << Command.which("ibtool")
          cmd << "--export-strings-file " + Shellwords.escape("#{output_file}")
          cmd << Shellwords.escape("#{file}")
          Command.execute(cmd)
        end
      end

      def files(folder)
        return Dir.glob(File.join(folder, "**", "*.{xib,nib,storyboard}"))
      end
    end
  end
end
