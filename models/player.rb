# frozen_string_literal: true

require_relative 'person'

# shit class doc
class Player < Person
  def initialize(name, money)
    @name = name
    super(money)
  end

  def show_hand
    result = []
    @hand.each { |card| result << "#{card.name}#{card.suit}" }

    result
  end

  def show_points
    calculate_points
    @points
  end
end
