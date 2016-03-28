require 'pty'

module Applyrics
  class Command
    class << self
      def which(command)
        exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']

        ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
          exts.each do |ext|
            cmd_path = File.join(path, "#{command}#{ext}")
            return cmd_path if File.executable?(cmd_path) && !File.directory?(cmd_path)
          end
        end

        return nil
      end

      def execute(command)
        begin
          PTY.spawn(command) do |stdin, stdout, pid|
            stdin.each do |l|
              line = l.strip
              output << line

              #next unless print_all

              # Prefix the current line with a string
              #prefix.each do |element|
              #  line = element[:prefix] + line if element[:block] && element[:block].call(line)
              #end
            end
            Process.wait(pid)
          end
        rescue Errno::EIO
        rescue => ex
        end

        # Exit status for build command, should be 0 if build succeeded
        status = $?.exitstatus
        if status != 0
          o = output.join("\n")
          puts o
        end

        return output.join("\n")
      end
    end
  end
end
