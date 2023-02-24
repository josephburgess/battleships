require 'colorize'

class Game
  def initialize
    @unplaced_ships = %w[SSSSS SSSS SSS SS]
    @rows = 10
    @cols = 10
    @ships_at = []
    @hit = []
    @miss = []
  end

  attr_reader :unplaced_ships, :rows, :cols, :hit, :miss

  def place_ship(ship)
    set_of_coords = [[ship[:col], ship[:row]]]
    (ship[:length] - 1).times { set_of_coords << next_coord(ship) }
    put_on_grid_if_possible(set_of_coords, ship)
  end

  def ship_at?(x, y)
    @ships_at.include? [x, y]
  end

  def hit?(x, y)
    @hit.include? [x, y]
  end

  def miss?(x, y)
    @miss.include? [x, y]
  end

  def format_board
    (1..@rows).map do |y|
      (1..@cols).map do |x|
        next ' S '.green if ship_at?(x, y)

        next ' ~ '.cyan
      end.join
    end.join("\n")
  end

  def format_target_board
    (1..@rows).map do |y|
      (1..@cols).map do |x|
        next ' @ '.green if hit?(x, y)
        next ' x '.red if miss?(x, y)

        next ' ~ '.cyan
      end.join
    end.join("\n")
  end

  def attempt_shot(player, x, y)
    if player.ship_at?(x, y)
      @hit << [x, y]
      puts 'You hit a ship!'.green
    else
      @miss << [x, y]
      puts 'You missed!'.red
    end
  end

  private

  def next_coord(ship)
    ship[:orientation] == :vertical ? [ship[:col], ship[:row] += 1] : [ship[:col] += 1, ship[:row]]
  end

  def coord_not_on_grid?(set_of_coords)
    set_of_coords.flatten.any? { |n| n > 10 || n < 1 }
  end

  def coord_already_ship?(set_of_coords)
    set_of_coords.any? { |coord| @ships_at.include? coord }
  end

  def raise_error_if_cant_place_ship(set_of_coords)
    raise 'You cannot place a ship outside of the grid' if coord_not_on_grid?(set_of_coords)
    raise 'You cannot place a ship on another ship' if coord_already_ship?(set_of_coords)
  end

  def put_on_grid_if_possible(set_of_coords, ship)
    raise_error_if_cant_place_ship(set_of_coords)
    set_of_coords.each { |coord| @ships_at << coord }
    @unplaced_ships.delete_if { |vessel| vessel.length == ship[:length] }
  end
end
