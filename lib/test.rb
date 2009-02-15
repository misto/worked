require 'worked/inputparser'

n = InputParser.new.parse("from #{DateTime.now.hour - 2} on coding")

p n
p ((n.end - n.start) * 24).hours

#p n.time.from
#p n.time.to
