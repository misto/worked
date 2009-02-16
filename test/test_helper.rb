require 'stringio'
require 'test/unit'
require File.dirname(__FILE__) + '/../lib/worked'

module WorkedTestHelper
  def extract_tuple log

    s_from, s_to, activity = /(\S*)\s+(\S*)\s+(.*)/.match(log).captures

    from = DateTime.parse(s_from)
    to   = DateTime.parse(s_to)

    [ ((to - from) * 24).hours, activity ]
  end
end
