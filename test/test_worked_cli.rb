require File.join(File.dirname(__FILE__), "test_helper.rb")
require 'tempfile'
require 'enumerator'
require 'active_support'
require 'worked/cli'

class TestWorkedCli < Test::Unit::TestCase

  include WorkedTestHelper

  def setup
    @file = Tempfile.new("worked")
    reset_stdout
  end

  def reset_stdout
    @stdout_io = StringIO.new
  end

  def run_with argument
    Worked::CLI.execute(@stdout_io, argument, @file)
    @stdout = @stdout_io.read
  end

  def extract file
    File.open(file).enum_for(:each_line).collect do |line|
      extract_tuple line.strip
    end
  end

  def test_with_new_file
    run_with "5 hours on coding"
    run_with "16:05 to 18:20 on documentation and refactoring"

    first, second = extract(@file)

    assert 5.hours,                         first[0]
    assert 2.hours + 15.minutes,            second[0]

    assert "coding",                        first[1]
    assert "documentation and refactoring", second[1]

    assert_equal "Creating new file: \.worked\n", @stdout

    reset_stdout

    run_with "1 hour on refactoring"

    _, _, third = extract(@file)

    assert 1.hours,       third[0]
    assert "refactoring", third[1]

    assert_equal "", @stdout
  end
end
