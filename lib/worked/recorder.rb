require 'worked/inputparser'

class Recorder

  def initialize out
    @out = out
  end

  def record line
    from, to, activity = InputParser.parse(line)
    @out << "#{ from }\t#{ to }\t#{ activity }\n"
  end
end
