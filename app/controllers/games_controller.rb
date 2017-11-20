require 'open-uri'

class GamesController < ApplicationController
  def new
    letter = ('A'..'Z').to_a
    @letters = letter.sample(10)
  end

  def score
    @guess = params[:word]
    @grid = params[:letters]
    if included?
      if english_word?
        @results = "Congratulations #{@guess} is a valid English word"
      else
        @results = "Sorry but #{@guess} does not seem to be a valid English word.."
      end
    else
      @results = "Sorry but #{@guess} can't be build from #{@grid} ! "
    end
  end

  def english_word?
    response = open("https://wagon-dictionary.herokuapp.com/#{@guess}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def included?
    @guess.chars.all? { |letter| @guess.count(letter) <= @grid.count(letter) }
  end

end
