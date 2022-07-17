# frozen_string_literal: true

# Base class for participants
class Person
  attr_reader :money

  def initialize(money)
    @money = money
    @hand = []
    @points = 0
  end

  def check
    true
  end

  def take_card(card)
    @hand << card
  end

  def make_bet
    @money -= 10

    10
  end

  def take_prize(value)
    @money += value
  end

  def free_hand
    @hand = []
  end

  protected

  def calculate_points
    sum = 0
    ace_count = 0
    @hand.each do |card|
      if card.name == 'A'
        ace_count += 1
        next
      end
      sum += card.value
    end

    while ace_count >= 1
      sum += sum <= 10 ? 11 : 1
      ace_count -= 1
    end

    @points = sum
  end

  def show_hand
    @hand
  end

  def show_points
    @points
  end
end
