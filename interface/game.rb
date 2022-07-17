# frozen_string_literal: true

require_relative '../models/dealer'
require_relative '../models/player'

# shit class
class Game
  def initialize
    @starting_money = 100
    @pot = 0
    @open_hands = false
    super
  end

  def main
    print 'Enter your name: '
    name = gets.chomp
    player = Player.new(name, @starting_money)
    dealer = Dealer.new(@starting_money)

    collect_bets(dealer, player)
    initial_deal(dealer, player)

    loop do
      show_current_score(dealer, player)

      player_turn(dealer, player)

      dealer_turn(dealer) unless @open_hands

      next unless game_finished?(dealer) || @open_hands

      show_result(dealer, player)
      choose_winner(dealer, player)

      break unless play_again?

      player.free_hand
      dealer.free_hand

      collect_bets(dealer, player)
      initial_deal(dealer, player)
    end
  end

  def play_again?
    print 'Play again? (y/n) '
    case gets.chomp
    when 'y'
      true
    when 'n'
      false
    end
  end

  def choose_winner(dealer, player)
    dealer_points = dealer.open_points
    player_points = player.show_points

    if dealer_points > 21 && player_points > 21
      dealer.take_prize(10)
      player.take_prize(10)
      puts 'Draw!'
    elsif dealer_points > 21
      player.take_prize(20)
      puts 'You won!'
    elsif player_points > 21
      dealer.take_prize(20)
      puts 'You lose!'
    elsif player_points > dealer_points
      player.take_prize(20)
      puts 'You won!'
    elsif dealer_points > player_points
      dealer.take_prize(20)
      puts 'You lose!'
    else
      player.take_prize(10)
      dealer.take_prize(10)
      puts 'Draw!'
    end

    @pot = 0
  end

  def show_current_score(dealer, player)
    puts "Dealer:\nHand: #{dealer.show_masked_hand}\tPoints: **\n"
    puts "Player:\nMoney: #{player.money}\tHand: #{player.show_hand}\tPoints: #{player.show_points}"
  end

  def show_result(dealer, player)
    puts "Dealer:\nHand: #{dealer.open_hand}\tPoints: #{dealer.open_points}\n"
    puts "Player:\nMoney: #{player.money}\tHand: #{player.show_hand}\tPoints: #{player.show_points}"
  end

  def initial_deal(dealer, player)
    player.take_card(dealer.deal_card)
    dealer.take_card(dealer.deal_card)
    player.take_card(dealer.deal_card)
    dealer.take_card(dealer.deal_card)
  end

  def collect_bets(dealer, player)
    @pot += dealer.make_bet
    @pot += player.make_bet
  end

  def player_turn(dealer, player)
    # TODO: should return something, on what we'll call function and loop break
    puts "1: check\n2: take card\n3: open cards"
    print 'Enter your choice: '

    case gets.to_i
    when 1
      player.check
    when 2
      player.take_card(dealer.deal_card)
    when 3
      # TODO: implement, maybe not as player's method
      @open_hands = true
    end
  end

  def dealer_turn(dealer)
    dealer.make_choice
  end

  def game_finished?(dealer)
    dealer.count_cards_in_game >= 5
  end
end
