require File.dirname(__FILE__) + '/test_helper.rb'

class TestGrammar < Test::Unit::TestCase

  def setup
    @parser = InputParser.new
  end

  def test_hours
    assert_equal 5, hours("5 hours")
    assert_equal 5, hours("5hours")
    assert_equal 5, hours("5 h")
    assert_equal 5, hours("5h")
    assert_equal 5, hours("5")
  end

  def test_minutes
    assert_equal 10, minutes( "5 h 10 minutes")
    assert_equal 10, minutes( "5 h 10 m")
    assert_equal 10, minutes( "5 h 10m")
    assert_equal 10, minutes( "5h10m")
    assert_equal 10, minutes( "5:10")
  end

  def hours source
    res = parse(source)
    res.end.hours - res.start.hours
  end

  def minutes source
    res = parse(source)
    res.end.minutes - res.start.minutes
  end

  def parse source
    @parser.parse(source).start
  end

end
