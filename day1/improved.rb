# frozen_string_literal: true

def generate_calibration_value(line)
  digits = line.scan(/\d/)
  "#{digits.first}#{digits.last}".to_i
end

def generate_calibration_value_including_named_digits(line)
  # p first_digit_match_data # eg #<MatchData "two"> or #<MatchData "4">
  # p first_digit_match # eg "two" or "4"

  first_digit_match_data = line.match(/\d|one|two|three|four|five|six|seven|eight|nine/, 0)
  first_digit_match = first_digit_match_data[0]
  first_digit = convert_word_to_digit(first_digit_match) # "two" becomes "2"

  last_digit_match_data = line.reverse.match(/\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin/, 0)
  last_digit_match = last_digit_match_data[0].reverse
  last_digit = convert_word_to_digit(last_digit_match) # "two" becomes "2"

  "#{first_digit}#{last_digit}".to_i
end

WORD_TO_DIGIT = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9'
}.freeze

def convert_word_to_digit(word)
  return word if %w[1 2 3 4 5 6 7 8 9].include?(word)

  WORD_TO_DIGIT[word]
end

file_name = './day1/input.txt'
# file_name = './day1/input_control.txt' # expected total 142
# file_name = './day1/input_closeup.txt'

puts "Loading #{File.expand_path(file_name)}"

# part 1
puts 'Calibration Value'
total = 0
File.foreach(file_name) { |line| total += generate_calibration_value(line) }
puts "total: #{total}"

# part 2
puts 'Calibration Value including named digits'
total = 0
File.foreach(file_name) { |line| total += generate_calibration_value_including_named_digits(line) }
puts "total: #{total}"
