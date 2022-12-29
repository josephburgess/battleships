require 'colorize'

class UserInterface
  def initialize(io, player1, player2)
    @io = io
    @player1 = player1
    @player2 = player2
    @turn_count = 1
  end

  def run
    battleships_logo
    show 'Welcome to the game!'.light_green.underline
    show 'P1 set up your ships on a 10x10 grid first.'.light_red
    while @player1.unplaced_ships.length > 0
      show 'You have these ship lengths remaining:'.light_green + " #{ships_unplaced_message}"
      prompt_for_ship_placement
      show 'This is your board now:'.green.underline
      show @player1.format_board
    end
    show 'OKAY! P2 time to set up your ships on your 10x10 grid.'.light_red
    show 'Your board is a 10x10 grid.'.light_yellow
    show '10 columns (Left > Right), 10 rows (Top > Bottom)'.light_yellow
    while @player2.unplaced_ships.length > 0
      show 'You have these ship lengths remaining:'.light_green + "#{ships_unplaced_message}"
      prompt_for_ship_placement
      show 'This is your board now:'.green.underline
      show @player2.format_board
    end
    until @player1.hit.length == 14 || @player2.hit.length == 14
      if @turn_count.odd?
        show 'P1 take a shot'
        prompt_for_shot
        show @player1.format_target_board
      else
        show 'P2 take a shot'
        prompt_for_shot
        show @player2.format_target_board
      end
      @turn_count += 1
    end
    if @player1.hit.length == 14
      show 'Player 1 wins!'
    else
      show 'Player 2 wins!'
    end
  end

  private

  def show(message)
    @io.puts(message)
  end

  def prompt(message)
    @io.puts(message)
    @io.gets.chomp
  end

  def ships_unplaced_message
    if @player1.unplaced_ships.length > 0
      @player1.unplaced_ships.map do |ship|
        "#{ship.length}".light_red
      end.join(', ')
    else
      @player2.unplaced_ships.map do |ship|
        "#{ship.length}".light_red
      end.join(', ')
    end
  end

  def prompt_for_ship_placement
    ship_length = prompt 'Which ship length do you wish to place?'.light_yellow until ship_length =~ /[2-5]/
    ship_orientation = prompt 'Vertical or horizontal? [vh]'.light_yellow until ship_orientation =~ /[vh]/
    ship_col = prompt 'Which column [1-10] (left > right)?'.light_yellow
    ship_row = prompt 'Which row [1-10] (top > bottom)?'.light_yellow
    show 'OK.'.light_yellow
    if @player1.unplaced_ships.length > 0
      @player1.place_ship({
                            length: ship_length.to_i,
                            orientation: { 'v' => :vertical, 'h' => :horizontal }.fetch(ship_orientation),
                            col: ship_col.to_i,
                            row: ship_row.to_i
                          })
    else
      @player2.place_ship({
                            length: ship_length.to_i,
                            orientation: { 'v' => :vertical, 'h' => :horizontal }.fetch(ship_orientation),
                            col: ship_col.to_i,
                            row: ship_row.to_i
                          })
    end
  rescue StandardError => e
    puts "#{e.message}"
  end

  def prompt_for_shot
    target_col = prompt 'Which column [1-10] (left > right)?'.light_yellow
    target_row = prompt 'Which row [1-10] (top > bottom)?'.light_yellow
    show 'OK, firing!'.magenta
    if @turn_count.odd?
      @player1.attempt_shot(@player2, target_col.to_i, target_row.to_i)
    else
      @player2.attempt_shot(@player1, target_col.to_i, target_row.to_i)
    end
  end

  def battleships_logo
    puts '██████╗  █████╗ ████████╗████████╗██╗     ███████╗███████╗██╗  ██╗██╗██████╗ ███████╗'.colorize(:light_red)
    puts '██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██║     ██╔════╝██╔════╝██║  ██║██║██╔══██╗██╔════╝'.colorize(:magenta)
    puts '██████╔╝███████║   ██║      ██║   ██║     █████╗  ███████╗███████║██║██████╔╝███████╗'.colorize(:light_magenta)
    puts '██╔══██╗██╔══██║   ██║      ██║   ██║     ██╔══╝  ╚════██║██╔══██║██║██╔═══╝ ╚════██║'.colorize(:cyan)
    puts '██████╔╝██║  ██║   ██║      ██║   ███████╗███████╗███████║██║  ██║██║██║     ███████║'.colorize(:light_cyan)
    puts '╚═════╝ ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝     ╚══════╝'.colorize(:light_green)
  end
end
