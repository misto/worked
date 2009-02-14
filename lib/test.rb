require 'worked/inputparser'

n = InputGrammarParser.new.parse("1:10 on coding")

p n

p n.time.total
p n.activity.to_s
