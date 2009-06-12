require 'rubygems'
require 'gruff'

require 'worked/reader'

module Worked

  class Graph

    def self.create_weekly entries, output_file
      create(entries, output_file)
    end

    def self.create_daily entries, output_file
      create(entries, output_file)
    end

    private

    def self.create entries, output_file

      g = Gruff::Bar.new
      g.title = "My Work Hours"
      g.y_axis_increment = 2
      g.y_axis_label = "Hours"
      g.x_axis_label = "Week of the Year"

      g.data("Total: #{entries.sum{|e| e.hours.to_f}.to_i.to_s} Hours", entries.collect {|e| e.hours.to_f})

      g.minimum_value = 0

      g.labels = entries.inject({}) {|h, e|  h.merge( { h.size => e.date.to_s }) }

      g.write output_file
    end
  end
end
