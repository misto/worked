require File.dirname(__FILE__) + '/test_helper.rb'
require 'worked/reader'
require 'mathn'

class TestReader < Test::Unit::TestCase

  def test_single_day
    data = <<-EOS
2009-04-21T21:26:00+00:00       2009-04-21T22:26:00+00:00       fixed bugs
    EOS

    recorded = Worked::Reader.read(data)

    assert_equal 17, recorded[0].week_of_year
    assert_equal 1, recorded[0].hours
  end

  def test_single_day_two_records
    data = <<-EOS
2009-04-21T21:26:00+00:00       2009-04-21T22:26:00+00:00       fixed bugs
2009-04-21T23:26:00+00:00       2009-04-21T23:46:00+00:00       fixed bugs
    EOS

    recorded = Worked::Reader.read(data)

    assert_equal 4/3, recorded[0].hours
  end

  def test_multiple_days
    data = <<-EOS
2009-04-21T21:00:00+00:00       2009-04-21T22:30:00+00:00       fixed bugs
2009-04-24T17:00:00+00:00       2009-04-24T23:30:00+00:00       fixed bugs
    EOS

    recorded = Worked::Reader.read(data)

    assert_equal 3/2, recorded[1].hours
    assert_equal 13/2, recorded[0].hours
  end

  def test_multiple_weeks
    data = <<-EOS
2009-04-21T21:00:00+00:00       2009-04-21T22:30:00+00:00       fixed bugs
2009-05-24T17:00:00+00:00       2009-05-24T23:30:00+00:00       fixed bugs
    EOS

    recorded = Worked::Reader.read(data)

    assert_equal 17, recorded[1].week_of_year
    assert_equal 22, recorded[0].week_of_year
  end

  def test_januar_first
    data = <<-EOS
2009-01-01T00:00:00+00:00       2009-01-1T22:00:00+00:00       fixed bugs
    EOS

    recorded = Worked::Reader.read(data)

    assert_equal 1, recorded[0].week_of_year
    assert_equal 22, recorded[0].hours
  end

  def test_worked_over_midnight
    data = <<-EOS
2009-01-01T23:00:00+00:00       2009-01-02T02:00:00+00:00       fixed bugs
    EOS

    recorded = Worked::Reader.read(data)

    assert_equal 3, recorded[0].hours
  end
end
