require 'worked/inputparser'

class Date
  def week_of_year
    strftime("%U").to_i + 1
  end
end

module Worked

  class Entry < Struct.new(:hours, :date)
    def week_of_year
      date.week_of_year
    end

    def <=> other
      self.date <=> other.date
    end
  end

  class Reader

    def self.by_week data
      create_entries merge_by_week read_all_entries data
    end

    def self.read data
      create_entries merge_by_day read_all_entries data
    end

    private

    def self.extract_times line
      from, to, rest = line.split

      [DateTime.parse(from), DateTime.parse(to)]
    end

    def self.read_all_entries data
      data.to_a.collect do |line|
        from, to = extract_times line
        Entry.new((to - from) * 24, from.to_date)
      end
    end

    def self.merge_by_week entries
      merge_entries(entries) {|e| e.week_of_year}
    end

    def self.merge_by_day entries
      merge_entries(entries) {|e| e.date}
    end

    def self.merge_entries entries
      merged = ActiveSupport::OrderedHash.new(0)

      entries.each do |entry|
        merged[yield(entry)] += entry.hours
      end

      merged
    end

    def self.create_entries entries
      entries.collect do |date, hours|
        Entry.new(hours, date)
      end
    end
  end
end
