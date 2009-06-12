require 'optparse'
require 'worked/recorder'
require 'worked/graph'

module Worked
  class CLI
    def self.execute(stdout, arguments, file)

      if arguments.empty?
        parse_options(stdout, ["--help"], file)
      end

      begin

	      try_to_parse(file, arguments.join(" "))

      rescue CannotParse

	      options = parse_options(stdout, arguments, file)

	      if options[:graph_path]

	        graph(stdout, file, options[:graph_path])

	      end
      end
    end

    def self.try_to_parse file, string

      Recorder.new(file).record(string)
    end

    def self.graph stdout, file, path

      Graph::create_weekly(Reader::by_week(file.readlines), path)

      stdout.puts "Graph saved to #{path}."
    end

    def self.parse_options(stdout, arguments, file)

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
