require 'optparse'

module Worked
  class CLI
    def self.execute(stdout, arguments, file)

      Recorder.new(file).record(arguments)

      #options = {
      #  :path     => '~'
      #}

      #parser = OptionParser.new do |opts|
      #  opts.banner = <<-BANNER.gsub(/^          /,'')
      #    This application is wonderful because...

      #    Usage: #{File.basename($0)} [options]

      #    Options are:
      #  BANNER
      #  opts.separator ""
      #  opts.on("-p", "--path=PATH", String,
      #          "This is a sample message.",
      #          "For multiple lines, add more strings.",
      #          "Default: ~") { |arg| options[:path] = arg }
      #  opts.on("-h", "--help",
      #          "Show this help message.") { stdout.puts opts; exit }

      #  opts.parse!(arguments)
      #end

      #path = options[:path]

    end
  end
end
