# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
def get_adjacent_coordinates(token_index, token_length, line_index, line_length, line_count)
  lookup_cols_index_start = token_index.positive? ? token_index - 1 : 0
  lookup_cols_index_end = token_index + token_length

  # it's got the line terminating character that's why we need to subtract 2 not 1
  lookup_cols_index_end = line_length - 2 if lookup_cols_index_end > (line_length - 2)

  rows_to_lookup = []
  rows_to_lookup.push(line_index - 1) if line_index.positive?
  rows_to_lookup.push(line_index + 1) if line_index < line_count

  {
    "lookup_cols_index_start": lookup_cols_index_start,
    "lookup_cols_index_end": lookup_cols_index_end,
    "rows_to_lookup": rows_to_lookup
  }
end
# rubocop:enable Metrics/MethodLength

def is_number(value)
  result = value.match(/\d+/)
  result&.length&.positive?
end

def is_symbol(char)
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

      adjacent_coordinates = get_adjacent_coordinates(char_count_in_line,
                                                      token.length, line_index, line.length, line_counter)

      lookup_cols_index_start, lookup_cols_index_end, rows_to_lookup = adjacent_coordinates.values_at(
        :lookup_cols_index_start, :lookup_cols_index_end, :rows_to_lookup
      )

      adjacent_symbol_found = false
      adjacent_symbol_found = true if is_symbol(line[lookup_cols_index_start]) || is_symbol(line[lookup_cols_index_end])

      rows_to_lookup.each do |row|
        for col_index in lookup_cols_index_start..lookup_cols_index_end
          adjacent_symbol_found = true if is_symbol(values_by_row_hash[row][col_index])
          end
      end

      if adjacent_symbol_found == true
        part_numbers.push({ 'token' => token, 'line_index' => line_index,
                            'col_index' => char_count_in_line })
      end
    end
    char_count_in_line += token.length + 1
  end

end
# rubocop:enable Style/For

total = 0

part_numbers.each do |part_number|
  total += part_number['token'].to_i
end

puts 'Part Numbers Total'
puts total
# 520135

# A gear is any * symbol that is adjacent to exactly two part numbers.
# find every *
# find adjacency coordinates
# see which part numbers are there
# the edge case will be more than two part numbers being adjacent and maybe adjacent *s
