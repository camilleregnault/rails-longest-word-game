require 'json'
require 'open-uri'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = VOWELS.to_a.sample(5)
    @letters += ('A'..'Z').to_a.sample(5)
    @letters = @letters.join(' ')
    # @letters = Array.new(5) { VOWELS.sample }
    # @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    # @letters.shuffle!.split(',')
  end

  def letter_in_grid(your_word)
    your_word.chars.sort.all? { |letter| @letters.include?(letter) }
  end

  def score
    @letters = params[:letters]
    @your_word = (params[:your_word] || "").upcase

    url = "https://wagon-dictionary.herokuapp.com/#{@your_word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)

    case
    when @your_word.length == 0 || @your_word.length > 10
      @result = "Sorry but #{@your_word} can't be built out of the letters"
    when !word['found']
      @result = "Sorry but #{@your_word} does not seem to be valid English word..."
    when !letter_in_grid(@your_word)
      @result = "Wrong answer."
    else @result = "Congratulations!!!!"
    end
  end
end
