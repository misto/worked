require 'active_support'
require 'treetop'
require 'worked/inputgrammar'

class Treetop::Runtime::SyntaxNode

  attr_reader :minutes

  def to_i
    text_value.gsub(/\D/, '').to_i
  end
end

class InputParser

  def parse source

  end
end
