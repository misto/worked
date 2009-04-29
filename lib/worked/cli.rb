require 'optparse'
require 'worked/recorder'
require 'worked/graph'

module Worked
  class CLI
    def self.execute(stdout, arguments, file)

      begin
        Recorder.new(file).record(arguments.join(" "))
      rescue Exception => e
        options(stdout, arguments, file) 
      end
    end

    def self.options(stdout, arguments, file)

      options = show_options(stdout, arguments, file)

      graph_path = options[:graph_path]

      Graph::create_weekly(Reader::by_week(file.readlines), graph_path)

      stdout.puts "Graph saved to #{graph_path}."
    end

    def self.show_options(stdout, arguments, file)

      options = {}

      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          This application is wonderful!

          Usage: #{File.basename($0)} [options]
                 #{File.basename($0)} work time specification

          Options are:
        BANNER
        opts.separator ""
        opts.on("-g", "--graph=PATH", String,
                "Prints a graph to the specified file.") { |arg| 
                  options[:graph_path] = arg 
                }
        opts.on("-h", "--help",
                "Show this help message.") { stdout.puts opts; exit }

        opts.parse!(arguments)
      end

      options
    end
  end
end
