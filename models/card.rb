# frozen_string_literal: true

# Basic class for card entity
class Card
  attr_reader :name, :suit, :value

  def initialize(name, suit, value)
    @name = name
    @suit = suit
    @value = value
  end
end
