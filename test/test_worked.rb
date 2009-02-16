require File.dirname(__FILE__) + '/test_helper.rb'

require 'worked/recorder'

class TestWorked < Test::Unit::TestCase

  include WorkedTestHelper

  def test_hours_and_activity
    assert_record 5.hours,              "coding",             "5 hours on coding"
    assert_record 5.hours,              "coding and writing", "4 to 9 on coding and writing"
  end

  def test_hours_and_minutes_and_activity
    assert_record 5.hours + 10.minutes, "coding and writing", "4 to 9:10 on coding and writing"
    assert_record 5.hours +  5.minutes, "coding",             "5 hours 5 minutes on coding"
  end

  def test_minutes_and_activity
    assert_record 5.minutes,              "coding",             "5 minutes on coding"
  end

  def assert_record exp_duration, exp_activity, source
    hours, activity = record_and_extract_duration(source)

    assert_equal exp_duration, hours
    assert_equal exp_activity, activity
  end

  def record_and_extract_duration source
    log = ""

    Recorder.new(log).record(source)

    extract_tuple(log)
  end
end
