class Game
  def initialize
    @unplaced_ships = %w[SSSSS SSSS SSS SS]
    @rows = 10
    @cols = 10
    @ships_at = []
  end

  attr_reader :unplaced_ships, :rows, :cols

  def place_ship(ship)
    coords = [[ship[:col], ship[:row]]]
    (ship[:length] - 1).times { coords << next_coord(ship) }
    put_on_grid_if_possible(coords, ship)
  end

  def ship_at?(x, y)
    @ships_at.include? [x, y]
  end

  private

  def next_coord(ship)
    ship[:orientation] == :vertical ? [ship[:col], ship[:row] += 1] : [ship[:col] += 1, ship[:row]]
  end

  def coord_not_on_grid?(coords)
    coords.flatten.any? { |n| n > 10 || n < 1 }
  end

  def coord_already_ship?(coords)
    coords.any? { |coord| @ships_at.include? coord }
  end

  def raise_error_if_cant_place_ship(coords)
    raise 'You cannot place a ship outside of the grid' if coord_not_on_grid?(coords)
    raise 'You cannot place a ship on another ship' if coord_already_ship?(coords)
  end

  def put_on_grid_if_possible(coords, ship)
    raise_error_if_cant_place_ship(coords)
    coords.each { |coord| @ships_at << coord }
    @unplaced_ships.delete_if { |vessel| vessel.length == ship[:length] }
  end
end
