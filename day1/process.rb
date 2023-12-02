# frozen_string_literal: true

def generate_calibration_value(line)
  # On each line, the calibration value can be found by combining the first digit and the
  # last digit (in that order) to form a single two-digit number
  # eg 1abc2 -> 12

  characters = line.split ''

  digits =   characters.select { |v| v =~ /\d/ }

  if digits.length > 1
    "#{digits.first}#{digits.last}".to_i
  else
    "#{digits.first}".to_i
  end

  "#{digits.first}#{digits.last}".to_i
end

def generate_calibration_value_including_parsing_words(line)
  prev_line = line
  new_line = replace_first_digit_as_text(prev_line)

  while new_line.length < prev_line.length
    prev_line = new_line
    new_line = replace_first_digit_as_text(prev_line)
  end

  characters = new_line.split ''

  digits =   characters.select { |v| v =~ /\d/ }

  "#{digits.first}#{digits.last}".to_i
end

def replace_first_digit_as_text(line)
  characters = line.split ''

  #  puts ''
  #  puts "line: #{line} - iterating 0 to #{characters.length - 3}"
  #  puts ''

  for index in 0..characters.length - 3

    # we can make at least a three letter word
    if index <= characters.length - 3
      result = get_number(characters[index..index + 2])
      unless result.nil?
        characters[index] = result
        # remove these
        # don't replace the last character, in case it is needed for overlap
        # characters.delete_at(index + 2)
        characters.delete_at(index + 1)
        # exit this loop - will returning our new string do so?
        # puts "** returning #{characters.join}"
        return characters.join
      end
    end

    # we can make at least a four letter word
    if index <= characters.length - 4
      result = get_number(characters[index..index + 3])
      unless result.nil?
        characters[index] = result
        # remove these
        # don't replace the last character, in case it is needed for overlap
        # characters.delete_at(index + 3)
        characters.delete_at(index + 2)
        characters.delete_at(index + 1)
        # exit this loop - will returning our new string do so?
        # puts "** returning #{characters.join}"

        return characters.join
      end
    end

    # we can make at least a five letter word
    next unless index <= characters.length - 5

    result = get_number(characters[index..index + 4])
    next if result.nil?

    characters[index] = result
    # don't replace the last character, in case it is needed for overlap
    # characters.delete_at(index + 4)
    characters.delete_at(index + 3)
    characters.delete_at(index + 2)
    characters.delete_at(index + 1)
    # puts "** returning #{characters.join}"

    return characters.join
  end

  line
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
def get_number(letters)
  word = letters.join
  # puts "considering #{word}"

  if letters.length == 3
    return 1 if word == 'one'
    return 2 if word == 'two'
    return 6 if word == 'six'
  end

  if letters.length == 4
    return 4 if word == 'four'
    return 5 if word == 'five'
    return 9 if word == 'nine'
  end

  if letters.length == 5
    return 3 if word == 'three'
    return 7 if word == 'seven'
    return 8 if word == 'eight'
  end

  nil
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

file_name = './day1/input.txt'
# file_name = './day1/input_control.txt' # expected total 142
# file_name = './day1/input_closeup.txt'

puts "Loading #{File.expand_path(file_name)}"

total = 0

puts 'Calibration Value'

File.foreach(file_name) { |line| total += generate_calibration_value(line) }

puts "total: #{total}"

puts 'Calibration Value parsing integers expressed as strings (eg 1 is one)'

total = 0

File.foreach(file_name) do |line|
  result = generate_calibration_value_including_parsing_words(line)
  # puts " result: #{result}"
  total += result
end

puts "total: #{total}"
