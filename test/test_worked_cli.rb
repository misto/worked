require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'tempfile'
require 'enumerator'
require 'active_support'
require 'worked/cli'

class TestWorkedCli < Test::Unit::TestCase

  include WorkedTestHelper

  def setup
    @file = Tempfile.new("worked")
    @filename = @file.path
    reset_stdout
  end

  def reset_stdout
    @stdout_io = StringIO.new
  end

  def run_with argument
    Worked::CLI.execute(@stdout_io, [argument], @file)
    @file.flush
  end

  def extract file
    File.open(file).enum_for(:each_line).collect do |line|
      extract_tuple line.strip
    end
  end

  def test_with_new_file
    @file.open
    run_with "5 hours on coding"
    run_with "16:05 to 18:20 on documentation and refactoring"

    first, second = extract(@filename)

    assert 5.hours,                         first[0]
    assert 2.hours + 15.minutes,            second[0]

    assert "coding",                        first[1]
    assert "documentation and refactoring", second[1]

    assert_equal "", @stdout_io.read

    reset_stdout

    run_with "1 hour on refactoring"
    @file.close

    _, _, third = extract(@filename)

    assert 1.hours,       third[0]
    assert "refactoring", third[1]

    assert_equal "", @stdout_io.read
  end
end
