require 'game'

describe Game do
  before(:each) do
    @game = Game.new
  end
  it 'allows users to place unplaced ships on a board' do
    @game.place_ship({
                       length: 3,
                       orientation: :vertical,
                       col: 2,
                       row: 3
                     })
    expect(@game.ship_at?(2, 3)).to eq true
    expect(@game.ship_at?(2, 4)).to eq true
    expect(@game.ship_at?(2, 5)).to eq true
  end
  it 'deletes used ships from array when placed' do
    @game.place_ship({
                       length: 3,
                       orientation: :vertical,
                       col: 2,
                       row: 3
                     })
    expect(@game.unplaced_ships).to eq %w[SSSSS SSSS SS]
  end
  it 'will raise an error if attempting to place ship overlapping another ship' do
    @game.place_ship({
                       length: 3,
                       orientation: :vertical,
                       col: 2,
                       row: 3
                     })
    expect do
      @game.place_ship({
                         length: 3,
                         orientation: :vertical,
                         col: 2,
                         row: 3
                       })
    end.to raise_error 'You cannot place a ship on another ship'
  end

  it 'will raise an error if attempting to place a ship off the grid' do
    expect do
      @game.place_ship({
                         length: 3,
                         orientation: :vertical,
                         col: 12,
                         row: 3
                       })
    end.to raise_error 'You cannot place a ship outside of the grid'
  end
end
