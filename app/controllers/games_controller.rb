require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10) * ' '
  end

  def letter_in_grid(your_word)
    your_word.chars.sort.all? { |letter| @letters.include?(letter) }
  end

  def score
    @letters = params[:letters]
    @your_word = params[:your_word].upcase

    url = "https://wagon-dictionary.herokuapp.com/#{@your_word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)

    case
    when @your_word.length == 0 || @your_word.length > 10
      @result = "Sorry but #{@your_word} can't be built out of the letters"
    when !word['found']
      @result = "Sorry but #{@your_word} does not seem to be valid English word..."
    when letter_in_grid(@your_word)
      @result = "wrong"
    else @result = "Congratulations!!!!"
    end
  end
end
