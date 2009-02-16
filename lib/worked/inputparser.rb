require 'active_support'
require 'treetop'
require 'worked/inputgrammar'

class Treetop::Runtime::SyntaxNode

  attr_reader :minutes

  def to_i
    text_value.gsub(/\D/, '').to_i
  end

  def from
    time_to_seconds_from_day(DateTime.now - total)
  end

  def to
    time_to_seconds_from_day(DateTime.now)
  end

  def time_to_seconds_from_day t
    t.hour.hours + t.min.minutes
  end
end

class ParseResult
  attr_reader :start, :end, :activity

  def initialize t_start, t_end, activity
    @start = t_start
    @end = t_end
    @activity = activity
  end

end

class InputParser

  def self.parse source
    root = InputGrammarParser.new.parse(source)

    from, to = root.time.from, root.time.to

    if from > to
      from -= 24.hours
    end

    now      = DateTime.now
    midnight = DateTime.new(now.year, now.month, now.day)

    ParseResult.new(midnight + from.seconds, midnight + to.seconds, root.activity.to_s)
  end
end



