require 'worked/inputparser'

n = InputParser.parse("5 minutes on coding")

p n
p ((n.end - n.start) * 24).hours

#p n.time.from
#p n.time.to
