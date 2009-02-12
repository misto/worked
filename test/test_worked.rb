require File.dirname(__FILE__) + '/test_helper.rb'

class TestWorked < Test::Unit::TestCase

  def test_hours_and_activity
    assert_record 5.hours,              "coding",             "5 hours on coding"
    assert_record 5.hours,              "coding and writing", "4 to 9 on coding and writing"
    assert_record 5.hours + 10.minutes, "coding and writing", "4 to 9:10 on coding and writing"
    assert_record 5.hours +  5.minutes, "coding",             "5 hours 5 minutes on coding"
  end

  def assert_record exp_duration, exp_activity, source
    hours, activity = record_and_extract(source)

    assert_equal exp_duration, hours
    assert_equal exp_activity, activity
  end

  def record_and_extract_duration source
    log = ""

    Worked.new(log).record(source)

    s_from, s_to, activity = /(\S*) (\S*) (\S*)/.match(log).captures

    from = DateTime.parse(s_from)
    to   = DateTime.parse(s_to)

    [ ((to - from) * 24).hours, activity ]
  end
end
