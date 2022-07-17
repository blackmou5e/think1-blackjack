# frozen_string_literal: true

require_relative 'person'
require_relative '../utils/utils'

# Class for Dealer
class Dealer < Person
  def initialize(money)
    @dealt_cards = []
    super
  end

  def deal_card
    card = generate_card
    card = generate_card while @dealt_cards.include?("#{card.name}#{card.suit}")
    @dealt_cards << "#{card.name}#{card.suit}"

    card
  end

  def count_cards_in_game
    @dealt_cards.size
  end

  def show_masked_hand
    @hand.map { |_card| '**' }
  end

  def make_choice
    if @points < 17
      take_card(deal_card)
    else
      check
    end
  end

  def open_hand
    result = []
    @hand.each { |card| result << "#{card.name}#{card.suit}" }

    result
  end

  def open_points
    calculate_points
    show_points
  end
end
