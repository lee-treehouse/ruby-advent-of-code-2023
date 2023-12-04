# frozen_string_literal: true

def generate_calibration_value(line)
  digits = line.scan(/\d/)
  "#{digits.first}#{digits.last}".to_i
end

file_name = './day1/input.txt'
# file_name = './day1/input_control.txt' # expected total 142
# file_name = './day1/input_closeup.txt'

puts "Loading #{File.expand_path(file_name)}"

puts 'Calibration Value'
total = 0
File.foreach(file_name) { |line| total += generate_calibration_value(line) }
puts "total: #{total}"
