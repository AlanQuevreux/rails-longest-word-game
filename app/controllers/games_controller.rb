class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid].split(" ")
    if !word_in_grid?(@word, @grid)
      @result = "Le mot ne peut pas être créé à partir de la grille d’origine."
    elsif !english_word?(@word)
      @result = "Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide."
    else
      @result = "Le mot est valide d’après la grille et est un mot anglais valide."
    end
  end

  private

  def word_in_grid?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end
