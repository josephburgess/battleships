class UserInterface
  def initialize(io, player1, player2)
    @io = io
    @player1 = player1
    @player2 = player2
    @turn_count = 1
  end

  def run
    show 'Welcome to the game!'
    show 'P1 set up your ships first.'
    while @player1.unplaced_ships.length > 0
      show "You have these ships remaining: #{ships_unplaced_message}"
      prompt_for_ship_placement
      show 'This is your board now:'
      show @player1.format_board
    end
    show 'OKAY! P2 time to set up your ships.'
    while @player2.unplaced_ships.length > 0
      show "You have these ships remaining: #{ships_unplaced_message}"
      prompt_for_ship_placement
      show 'This is your board now:'
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
        "#{ship.length}"
      end.join(', ')
    else
      @player2.unplaced_ships.map do |ship|
        "#{ship.length}"
      end.join(', ')
    end
  end

  def prompt_for_ship_placement
    ship_length = prompt 'Which do you wish to place?'
    ship_orientation = prompt 'Vertical or horizontal? [vh]'
    ship_col = prompt 'Which column?'
    ship_row = prompt 'Which row?'
    show 'OK.'
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
    target_col = prompt 'Which column'
    target_row = prompt 'Which row'
    show 'OK, firing!'
    if @turn_count.odd?
      @player1.attempt_shot(@player2, target_col.to_i, target_row.to_i)
    else
      @player2.attempt_shot(@player1, target_col.to_i, target_row.to_i)
    end
  end
end
