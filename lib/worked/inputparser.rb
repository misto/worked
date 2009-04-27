require 'treetop'
require 'worked/inputgrammar'

class Treetop::Runtime::SyntaxNode

  # Remove all clutter ('hour', ':', etc) from the
  # time and turn into an integer
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

  # Default value so we don't have to care whether
  # there really is a minute component
  def minutes
    0
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

    [midnight + from.seconds, midnight + to.seconds, root.activity.text_value]
  end
end



