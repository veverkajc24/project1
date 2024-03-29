class Player
    attr_reader :name, :score

    def initialize(name)
      @name = name
      @score = 0
    end

    def to_s
      "#{@name}"
    end

    def increment_score
      @score += 1
    end
  end
