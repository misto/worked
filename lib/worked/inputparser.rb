require 'active_support'
require 'treetop'
require 'worked/inputgrammar'

class Treetop::Runtime::SyntaxNode

  attr_reader :from, :to, :total

  # Remove all clutter ('hour', ':', etc) from the
  # time and turn into an integer
  def to_i
    text_value.gsub(/\D/, '').to_i
  end

  # Default value so we don't have to care whether
  # there really is a minute component
  def minutes
    0
  end
end

class InputGrammarParser
  def initialize
    @root = nil
  end
end

class CannotParse < Exception ; end

class InputParser

  def self.parse(source, now = DateTime.now)

    from, to, total, activity = parse_input source

    from ||= time_in_seconds_from_day(now - total)
    to   ||= time_in_seconds_from_day(now)

    if from > to
      from -= 24.hours
    end

    midnight = DateTime.new(now.year, now.month, now.day)

    [midnight + from.seconds, midnight + to.seconds, activity]
  end

  private

  def self.parse_input source
    root = InputGrammarParser.new.parse(source)

    raise CannotParse unless root

    [root.time.from, root.time.to, root.time.total, root.activity.text_value]
  end

  def self.time_in_seconds_from_day t
    t.hour.hours + t.min.minutes
  end
end



