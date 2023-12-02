# frozen_string_literal: true

MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

def get_games_value(games, game_id)
  game_is_possible = true
  games.each do |game|
    colours = game.split(',')
    exceeds_maximum = does_any_colour_exceed_maximum(colours)
    game_is_possible = false if exceeds_maximum == true
  end

  game_is_possible ? game_id.to_i : 0
end

def generate_games_value(line)
  # TODO: replace with ruby destructuring
  split_line = line.split(':')
  game_title = split_line[0]
  game_id = game_title.split(' ')[1]
  game_result = split_line[1]

  games = game_result.split(';')
  get_games_value(games, game_id)
end

def does_any_colour_exceed_maximum(colours)
  colours.each do |colour|
    colour_detail = colour.split(' ')
    colour_count = colour_detail[0]
    colour_name  = colour_detail[1]

    colour_exceeds_maximum = exceeds_maximum(colour_name, colour_count.to_i)
    return true if colour_exceeds_maximum == true

    # puts "#{colour_name} (#{colour_count}) - #{exceeds_maximum(colour_name, colour_count.to_i)}"
  end
  false
end

def exceeds_maximum(colour_name, colour_count)
  return true if colour_name == 'red' && colour_count > MAX_RED
  return true if colour_name == 'blue' && colour_count > MAX_BLUE
  return true if colour_name == 'green' && colour_count > MAX_GREEN

  false
end

file_name = './day2/input.txt'

puts "Loading #{File.expand_path(file_name)}"

total = 0

puts 'Game Value'

File.foreach(file_name) { |line| total += generate_games_value(line) }

puts "total: #{total}"
