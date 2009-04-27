require 'worked/inputparser'

class Date
  def week_of_year
    strftime("%U").to_i
  end
end

module Worked

  class Entry < Struct.new(:hours, :date)
    def week_of_year
      date.week_of_year
    end

  end

  class Reader

    def self.read data
      merge_entries(read_all_entries(data))
    end

    private

    def self.read_all_entries data
      data.to_a.collect do |line|
        from_s, to_s, rest = line.split

        from = DateTime.parse(from_s)
        to   = DateTime.parse(to_s)

        Entry.new((to - from) * 24, from.to_date)
      end
    end

    def self.merge_entries entries
      merged = Hash.new(0)

      entries.each do |entry|
        merged[entry.date] += entry.hours
      end

      merged.collect do |date, hours|
        Entry.new(hours, date)
      end
    end
  end
end
