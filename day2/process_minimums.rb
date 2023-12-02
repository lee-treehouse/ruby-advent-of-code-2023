# frozen_string_literal: true

MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
def get_minimums(games, _game_id)
  minimum_red = 0
  minimum_green = 0
  minimum_blue = 0

  games.each do |game|
    colours = game.split(',')

    colours.each do |colour|
      colour_count, colour_name = colour.split(' ')
      minimum_red = colour_count.to_i if colour_name == 'red' && colour_count.to_i > minimum_red
      minimum_blue = colour_count.to_i if colour_name == 'blue' && colour_count.to_i > minimum_blue
      minimum_green = colour_count.to_i if colour_name == 'green' && colour_count.to_i > minimum_green
    end
  end

  [minimum_red, minimum_green, minimum_blue]
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def generate_games_power(line)
  # TODO: replace with ruby destructuring
  split_line = line.split(':')
  game_title = split_line[0]
  game_id = game_title.split(' ')[1]
  game_result = split_line[1]

  games = game_result.split(';')
  minimums = get_minimums(games, game_id)
  minimums[0] * minimums[1] * minimums[2]
end

file_name = './day2/input.txt'

puts "Loading #{File.expand_path(file_name)}"

puts 'Game Power'

total = 0

File.foreach(file_name) { |line| total += generate_games_power(line) }

puts "Total: #{total}"

puts "Unexpected total: #{total}. Expected:74229" if total != 74_229
