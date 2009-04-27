require File.dirname(__FILE__) + '/test_helper.rb'
require 'worked/reader'
require 'mathn'

class TestReader < Test::Unit::TestCase

  def test_single_day
    data = <<-EOS
2009-04-21T21:26:00+00:00       2009-04-21T22:26:00+00:00       fixed bugs
    EOS

    recorded = Worked::Reader.read(data)

    assert_equal 16, recorded[0].week_of_year
    assert_equal 1, recorded[0].hours
  end

  def test_single_day_two_records
    data = <<-EOS
2009-04-21T21:26:00+00:00       2009-04-21T22:26:00+00:00       fixed bugs
2009-04-21T23:26:00+00:00       2009-04-21T23:46:00+00:00       fixed bugs
    EOS

    recorded = Worked::Reader.read(data)

    assert_equal 16, recorded[0].week_of_year
    assert_equal 4/3, recorded[0].hours
  end
end
