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
    assert_equal 10, minutes("5 h 10 minutes")
    assert_equal 10, minutes("5 h 10 m")
    assert_equal 10, minutes("5 h 10m")
    assert_equal 10, minutes("5h10m")
    assert_equal 10, minutes("5:10")
  end

  def test_hour_ranges
    assert_equal  4.hours, range("13 to 17")
    assert_equal  4.hours, range("1 to 5")
    assert_equal  4.hours, range("1pm to 5pm")
    assert_equal  4.hours, range("1 pm to 5 pm")
    assert_equal 12.hours, range("1 am to 5 pm")
  end

  def test_hour_minute_ranges
    assert_equal 4.hours + 30.minutes, range("1 to 5:30")
    assert_equal 4.hours + 10.minutes, range("13:30 to 17:40")
  end

  def test_with_activity
    assert_equal "Testing", activity("5 hours on Testing")
    assert_equal "Testing and Refactoring", activity("1 to 5 on Testing and Refactoring")
  end

  def activity source
    parse(source).activity
  end

  def range source
    res = parse(source)
    (res.end - res.start).hours
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
