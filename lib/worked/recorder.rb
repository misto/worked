require 'worked/inputparser'

class Recorder

  def initialize out
    @out = out
  end

  def record line
    res =  InputParser.parse(line)
    @out << "#{res.start}\t#{res.end}\t#{res.activity}\n"
  end
end
