$LOAD_PATH << 'lib'
require 'game'
require 'user_interface'

class TerminalIO
  def gets
    Kernel.gets
  end

  def puts(message)
    Kernel.puts(message)
  end
end

io = TerminalIO.new
player1 = Game.new
player2 = Game.new
user_interface = UserInterface.new(io, player1, player2)
user_interface.run
