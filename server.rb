require "json"
require 'sinatra'
enable :sessions

post '/guess' do
  guess = JSON.parse(request.body.read)["guess"].to_i
  result = check_user_guess guess

  puts session[:server_guess]
  {result: result}.to_json
end

get '/' do
  session[:server_guess] = random_num # store comp guess for session
  erb :index
end


def random_num
  comp_num = Random.new
  comp_num.rand(100)
end

def check_user_guess user_guess
  if user_guess.between?(1, 100)
    result = compare_guesses session[:server_guess], user_guess
  else
    result = "please enter a number 1-100"
  end
end

def compare_guesses computer_guess, user_guess
  if user_guess == computer_guess
    session[:server_guess] = random_num
    "user wins"
  elsif user_guess.between?(computer_guess, computer_guess+15) || user_guess.between?(computer_guess-15, computer_guess)
    "you're close!"
  else
    "you're cold!"
  end
end
