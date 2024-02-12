class SetGame
  attr_reader :visible_cards

  def initialize
    @deck = generate_deck
    @visible_cards = deal_initial_cards
  end

  def display_board
    puts "Visible Cards:"
    @visible_cards.each_with_index do |card, index|
      puts "#{index + 1}. #{card}"
    end
  end

  def valid_set?(input)
    selected_cards = input.map { |index| @visible_cards[index - 1] }
    selected_cards.permutation(3).any? { |set| is_set?(set) }
  end

  def replace_cards(indices)
    indices.each { |index| @visible_cards[index - 1] = @deck.shift }
  end

  def game_over?
    @deck.empty? && !more_sets_available?
  end

  def more_sets_available?
    @visible_cards.combination(3).any? { |set| is_set?(set) }
  end

  def draw_more_cards
    new_cards = @deck.shift(3) # Draw 3 new cards
    @visible_cards.concat(new_cards) # Add them to visible cards
  end

  private

  def generate_deck
    deck = []
    (1..3).each do |color|
      (1..3).each do |fill|
        (1..3).each do |shape|
          (1..3).each do |number|
            deck << [color, fill, shape, number]
          end
        end
      end
    end
    deck.shuffle
  end

  def deal_initial_cards
    @deck.shift(16)
  end

  def is_set?(cards)
    cards.transpose.all? { |properties| properties.uniq.length == 1 || properties.uniq.length == 3 }
  end
end
