# frozen_string_literal: true

def process(line)
  puts line
end

def is_number(value)
  result = value.match(/\d+/)
  result&.length&.positive?
end

def isSymbol(char)
  result = char.match(/[^0-9.a-zA-Z]/)
  result&.length&.positive?
end

file_name = './day3/input.txt'

puts "Loading #{File.expand_path(file_name)}"

values_by_row_hash = {}

line_counter = -1

File.foreach(file_name) do |line|
  line_counter += 1
  values_by_row_hash[line_counter] = line
end

part_numbers = []

# rubocop:disable Style/For
for line_index in 0..line_counter
  line = values_by_row_hash[line_index]

  next unless line

  # first remove any of these characters  [^0-9.]

  sanitized_line = line.gsub(/[^0-9.]/, '.')

  tokens_in_line = sanitized_line.split '.'

  char_count_in_line = 0
  tokens_in_line.each do |token|
    if is_number(token)

      character_index = char_count_in_line

      lookup_cols_index_start = character_index.positive? ? character_index - 1 : 0
      lookup_cols_index_end = character_index + token.to_s.length

      # it's got the line terminating character that's why we need to subtract 2 not 1
      lookup_cols_index_end = line.length - 2 if lookup_cols_index_end > (line.length - 2)

      rows_to_lookup = []
      rows_to_lookup.push(line_index - 1) if line_index.positive?
      rows_to_lookup.push(line_index + 1) if line_index < line_counter

      adjacent_symbol_found = false
      adjacent_symbol_found = true if isSymbol(line[lookup_cols_index_start]) || isSymbol(line[lookup_cols_index_end])

      rows_to_lookup.each do |row|
        for col_index in lookup_cols_index_start..lookup_cols_index_end
          adjacent_symbol_found = true if isSymbol(values_by_row_hash[row][col_index])
          end
      end

      part_numbers.push(token) if adjacent_symbol_found == true
    end
    char_count_in_line += token.length + 1
  end

end
# rubocop:enable Style/For

total = 0

part_numbers.each do |part_number|
  total += part_number.to_i
end

puts total