require File.dirname(__FILE__) + '/test_helper.rb'

class TestGrammar < Test::Unit::TestCase

  def test_hours
    assert_equal 5.hours, hours("5 hours")
    assert_equal 5.hours, hours("5hours")
    assert_equal 5.hours, hours("5 h")
    assert_equal 5.hours, hours("5h")
    assert_equal 5.hours, hours("5")
  end

  def test_minutes
    assert_equal 10.minutes, minutes("5 h 10 minutes")
    assert_equal 10.minutes, minutes("5 h 10 m")
    assert_equal 10.minutes, minutes("5 h 10m")
    assert_equal 10.minutes, minutes("5h10m")
    assert_equal 10.minutes, minutes("5:10")
  end

  def test_hour_ranges
    assert_equal  4.hours, hours("13 to 17")
    assert_equal  4.hours, hours("1 to 5")
    assert_equal  4.hours, hours("1pm to 5pm")
    assert_equal  4.hours, hours("1 pm to 5 pm")
    assert_equal 16.hours, hours("1 am to 5 pm")
    assert_equal  2.hours, hours("11 to 1pm")
    assert_equal  2.hours, hours("11pm to 1am")
  end

  def test_hour_minute_ranges
    assert_equal 4.hours + 30.minutes, hours("1 to 5:30")
    assert_equal 4.hours + 10.minutes, hours("13:30 to 17:40")
  end

  def test_with_activity
    assert_equal "Testing", activity("5 hours on Testing")
    assert_equal "Testing and Refactoring", activity("1 to 5 on Testing and Refactoring")
  end

  def test_from_time
    assert_in_delta 2.hours, hours("from #{DateTime.now.hour - 2}:#{DateTime.now.min}"), 10.seconds #of delta
  end

  def activity source
    parse(source).last
  end

  def hours source
    res = parse("#{source} on X")
    ((res[1] - res[0]) * 24).hours
  end

  def minutes source
    hours(source) % 1.hour
  end

  def parse source
    InputParser.parse(source, DateTime.now )
  end

end
