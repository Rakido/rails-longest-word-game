require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
  	@random_letters = ('a'..'z').to_a.shuffle[0,10]
  end

  def score
  	
  	@answer = params[:answer].split("")
  	@random_letters = params[:grid].split("")
  	@score_answer = ""

  	serialized_response = open("https://wagon-dictionary.herokuapp.com/#{@answer.join("")}").read
  	serialized_word = JSON.parse(serialized_response)

  	if @answer - @random_letters != [] 
  		@score_answer = "Sorry but #{@answer.join("")} is not in the grid." 
  	elsif serialized_word["found"] == false
    	@score_answer = "Sorry but #{@answer.join("")} doesn't seem like a valid answer."
  	elsif serialized_word["found"]
    	@score_answer = "Congrats ! #{@answer.join("")} is an english word."
  	end
  end
end

