# frozen_string_literal: true

require_relative '../card'

SUITS = %w[♣ ♥ ♦ ♠].freeze
CARDS = {
  1 => 'A',
  2 => '2',
  3 => '3',
  4 => '4',
  5 => '5',
  6 => '6',
  7 => '7',
  8 => '8',
  9 => '9',
  10 => '10',
  11 => 'J',
  12 => 'Q',
  13 => 'K'
}.freeze

def generate_card
  name = CARDS[rand(1..13)]
  suit = SUITS[rand(4)]
  value = value_by_name(name)

  Card.new(name, suit, value)
end

def value_by_name(name)
  case name
  when 'J', 'Q', 'K'
    10
  when 'A'
    1
  else
    name.to_i
  end
end
