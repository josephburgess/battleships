class Game
  def initialize
    @carrier = %w[C C C C C]
    @battleship = %w[B B B B]
    @destroyer = %w[D D D]
    @submarine = %w[S S S]
    @patrol_boat = %w[P P]
    @unplaced_ships = [@carrier, @battleship, @destroyer, @submarine, @patrol_boat]
    @rows = 10
    @cols = 10
  end

  attr_reader :unplaced_ships, :rows, :cols

  def place_ship(ship)
    # I want place_ship to
    # 1. Receive the hash generated by the user input (length/orientation/row/col)
    # 2. Begin at correct location (row/col)
    # 3. Take direction from start point
    # 4. Increment by the length of ship chosen
    # 5. note each coordinate now taken up by the ship
  end

  def ship_at?(x, y); end
end
