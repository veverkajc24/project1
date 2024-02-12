require_relative 'player_creator'
require_relative 'set_game'

class Game
  def initialize
    @player_creator = PlayerCreator.new
    @players = []
    @set_game = SetGame.new
  end

  def add_players
    puts "Welcome! Let's set up the game."
    puts "Player 1, what's your name?"
    player_1_name = gets.chomp
    puts "Player 2, what's your name?"
    player_2_name = gets.chomp
    @players << Player.new(player_1_name)
    @players << Player.new(player_2_name)
    puts "Welcome #{@players[0].name} and #{@players[1].name}"
  end

  def start
    puts "This is the game of Set!!!"
    puts "The rules are as follows:"
    puts "Cards will be listed in the following format: Card #1. [color, fill, shape, number]"
    puts "The goal is to list three card numbers that satisfy the folliwng criteria: "
    puts "For a set to be valid, Each property must be the same or all different across all 3 cards"
    puts "For example, the set [1, 2, 2, 2], [1, 2, 2, 3], [1, 2, 2, 1] would be correct,"
    puts "And the set [2, 3, 1, 2], [2, 3, 2, 2], [2, 1, 3, 2] would be incorrect."
    play_game
  end

  private

  def play_game
    current_player_index = 0
  loop do
    display_current_score
    @set_game.display_board

    if @set_game.more_sets_available?
      puts "#{@players[current_player_index]}, what's your set? (e.g., 1 2 3)"
      input = gets.chomp.split.map(&:to_i)

      if @set_game.valid_set?(input)
        @set_game.replace_cards(input)
        @players[current_player_index].increment_score
      else
        puts "That doesn't look like a valid set. Better luck next time!"
      end
    else
      puts "No valid sets available. Drawing new cards..."
      @set_game.draw_more_cards
    end

    break if @set_game.game_over?

    current_player_index = (current_player_index + 1) % @players.length
  end

  display_final_scores
  end

  def display_current_score
    puts "\nCurrent Score:"
    @players.each do |player|
      puts "#{player.name}: #{player.score}"
    end
  end

  def display_final_scores
    puts "\nFinal Scores:"
    @players.each do |player|
      puts "#{player.name}: #{player.score}"
    end
  end
end
