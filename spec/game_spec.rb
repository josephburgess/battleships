require 'colorize'
require_relative '../lib/game'
require_relative '../lib/user_interface'

describe Game do
  let(:game) { Game.new }
  let(:ship) { { length: 2, orientation: :vertical, col: 1, row: 1 } }

  describe '#initialize' do
    it 'creates a game with unplaced ships, rows, cols, and empty hit and miss arrays' do
      expect(game.unplaced_ships).to eq %w[SSSSS SSSS SSS SS]
      expect(game.rows).to eq 10
      expect(game.cols).to eq 10
      expect(game.hit).to eq []
      expect(game.miss).to eq []
    end
  end

  describe '#place_ship' do
    it 'places a ship on the grid if possible' do
      game.place_ship(ship)
      expect(game.instance_variable_get(:@ships_at)).to eq [[1, 1], [1, 2]]
      expect(game.instance_variable_get(:@unplaced_ships)).to eq %w[SSSSS SSSS SSS]
    end

    it 'raises an error if the ship cannot be placed on the grid' do
      invalid_ship = { length: 3, orientation: :horizontal, col: 8, row: 11 }
      expect { game.place_ship(invalid_ship) }.to raise_error('You cannot place a ship outside of the grid')

      game.place_ship(ship)
      expect { game.place_ship(ship) }.to raise_error('You cannot place a ship on another ship')
    end
  end

  describe '#ship_at?' do
    it 'returns true if a ship is at the given coordinates' do
      game.instance_variable_set(:@ships_at, [[1, 1], [1, 2]])
      expect(game.ship_at?(1, 1)).to be true
      expect(game.ship_at?(1, 2)).to be true
      expect(game.ship_at?(2, 1)).to be false
    end
  end

  describe '#hit?' do
    it 'returns true if the given coordinates have been hit' do
      game.instance_variable_set(:@hit, [[1, 1], [2, 1]])
      expect(game.hit?(1, 1)).to be true
      expect(game.hit?(2, 1)).to be true
      expect(game.hit?(1, 2)).to be false
    end
  end

  describe '#miss?' do
    it 'returns true if the given coordinates have been missed' do
      game.instance_variable_set(:@miss, [[1, 1], [2, 1]])
      expect(game.miss?(1, 1)).to be true
      expect(game.miss?(2, 1)).to be true
      expect(game.miss?(1, 2)).to be false
    end
  end

  describe '#attempt_shot' do
    it 'adds the coordinates to @hit if the shot hits a ship' do
      game.instance_variable_set(:@ships_at, [[1, 1], [1, 2]])
      game.attempt_shot(game, 1, 1)
      expect(game.instance_variable_get(:@hit)).to eq [[1, 1]]
    end

    it 'adds the coordinates to @miss if the shot misses a ship' do
      game.instance_variable_set(:@ships_at, [[1, 1], [1, 2]])
      game.attempt_shot(game, 3, 3)
      expect(game.instance_variable_get(:@miss)).to eq [[3, 3]]
    end
  end
end

describe UserInterface do
  let(:io) { double('io').as_null_object }
  let(:player1) { double('player1') }
  let(:player2) { double('player2') }
  let(:ui) { UserInterface.new(io, player1, player2) }

  describe '#ships_unplaced_message' do
    it 'returns a string of ship lengths remaining for the current player' do
      allow(player1).to receive(:unplaced_ships).and_return(['SSS'])
      expect(ui.send(:ships_unplaced_message)).to eq '3'.light_red
      allow(player1).to receive(:unplaced_ships).and_return([])
      allow(player2).to receive(:unplaced_ships).and_return(%w[SS SS])
    end
  end
  describe '#prompt_for_ship_placement' do
    it 'prompts the player for ship placement and places the ship on the player board' do
      allow(ui).to receive(:prompt).and_return('2', 'v', '1', '1')
      allow(player1).to receive(:unplaced_ships).and_return(['SS'])
      expect(player1).to receive(:place_ship).with({
                                                     length: 2,
                                                     orientation: :vertical,
                                                     col: 1, row: 1
                                                   })
      ui.send(:prompt_for_ship_placement)
    end
  end

  describe '#prompt_for_shot' do
    it 'prompts the player for a shot and calls attempt_shot on the opposing player' do
      allow(ui).to receive(:prompt).and_return('1', '1')
      expect(player1).to receive(:attempt_shot).with(player2, 1, 1)
      ui.send(:prompt_for_shot)
    end
  end
end
