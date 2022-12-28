require 'user_interface'

# RSpec.describe UserInterface do
#   describe 'ship setup scenario' do
#     it 'allows the user to set up ships' do
#       io = double(:io)
#       player1 = double(:game, rows: 10, cols: 10)
#       player2 = double(:game, rows: 10, cols: 10)
#       interface = UserInterface.new(io, player1, player2)
#       expect(io).to receive(:puts).with('Welcome to the game!')
#       expect(io).to receive(:puts).with('P1 set up your ships first.')
#       expect(player1).to receive(:unplaced_ships).and_return([
#                                                                double(:ship, length: 2),
#                                                                double(:ship, length: 5)
#                                                              ])
#       expect(io).to receive(:puts).with('You have these ships remaining: 2, 5')
#       expect(io).to receive(:puts).with('Which do you wish to place?')
#       expect(io).to receive(:gets).and_return("5\n")
#       expect(io).to receive(:puts).with('Vertical or horizontal? [vh]')
#       expect(io).to receive(:gets).and_return("v\n")
#       expect(io).to receive(:puts).with('Which column?')
#       expect(io).to receive(:gets).and_return("3\n")
#       expect(io).to receive(:puts).with('Which row?')
#       expect(io).to receive(:gets).and_return("3\n")
#       expect(io).to receive(:puts).with('OK.')
#       expect(player1).to receive(:place_ship).with({
#                                                      length: 5,
#                                                      orientation: :vertical,
#                                                      col: 3,
#                                                      row: 3
#                                                    })
#       expect(io).to receive(:puts).with('This is your board now:')
#       allow(player1).to receive(:ship_at?).and_return(false)
#       allow(player1).to receive(:ship_at?).with(3, 3).and_return(true)
#       allow(player1).to receive(:ship_at?).with(3, 4).and_return(true)
#       allow(player1).to receive(:ship_at?).with(3, 5).and_return(true)
#       allow(player1).to receive(:ship_at?).with(3, 6).and_return(true)
#       allow(player1).to receive(:ship_at?).with(3, 7).and_return(true)
#       allow(player1).to receive(:format_board).and_return(:puts).with([
#         '..........',
#         '..........',
#         '..S.......',
#         '..S.......',
#         '..S.......',
#         '..S.......',
#         '..S.......',
#         '..........',
#         '..........',
#         '..........'
#       ].join("\n"))
#       interface.run
#     end
#   end

#   xit 'allows for setting up two player boards' do
#     io = double(:io)
#     player1 = double(:game, rows: 10, cols: 10)
#     player2 = double(:game, rows: 10, cols: 10)
#     interface = UserInterface.new(io, player1, player2)
#     expect(io).to receive(:puts).with('Welcome to the game!')
#     expect(io).to receive(:puts).with('P1 set up your ships first.')
#     expect(io).to receive(:puts).with('You have these ships remaining: 5, 4, 3, 2')
#     expect(io).to receive(:puts).with('Which do you wish to place?')
#     expect(io).to receive(:gets).and_return("2\n")
#     expect(io).to receive(:puts).with('Vertical or horizontal? [vh]')
#     expect(io).to receive(:gets).and_return("h\n")
#     expect(io).to receive(:puts).with('Which column?')
#     expect(io).to receive(:gets).and_return("2\n")
#     expect(io).to receive(:puts).with('Which row?')
#     expect(io).to receive(:gets).and_return("2\n")
#     expect(io).to receive(:puts).with('OK.')
#     expect(player1).to receive(:place_ship).with({ length: 2,
#                                                    orientation: :horizontal,
#                                                    col: 2,
#                                                    row: 2 })
#     expect(io).to receive(:puts).with('This is your board now:')
#     allow(player1).to receive(:format_board)
#     expect(io).to receive(:puts).with([
#       '..........',
#       '.SS.......',
#       '..........',
#       '..........',
#       '..........',
#       '..........',
#       '..........',
#       '..........',
#       '..........',
#       '..........'
#     ].join("\n"))
#   end
# end
