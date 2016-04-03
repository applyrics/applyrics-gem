require 'applyrics/command'
module Applyrics
  class IBTool
    class << self
      def run(folder, output_folder=nil)
        output_folder = folder if output_folder.nil?

        folder = File.expand_path(folder)
        output_folder = File.expand_path(output_folder)

        
      end
    end
  end
end
