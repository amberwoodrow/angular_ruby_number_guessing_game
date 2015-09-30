require "json"
require 'sinatra' # sinatra to run Ruby backend
enable :sessions # sessions to store computer guess till user guesses the right number

post '/guess' do
  guess = JSON.parse(request.body.read)["guess"].to_i
  message = check_user_guess guess

  session[:turns]
  puts session[:turns]
  puts session[:server_guess] # see what comp guess is for testng
  {result: message, turns: session[:turns]}.to_json # create a json obj from hash to send result
end

get '/' do
  session[:turns] = 0
  session[:server_guess] = random_num # store computer/server guess for session
  erb :index # render erb template on get "/"
end


def random_num 
  comp_num = Random.new
  comp_num.rand(20)
end

def check_user_guess user_guess # validates the user's input and responds, valid or no
  if user_guess.between?(1, 20)
    session[:turns]+=1
    compare_guesses session[:server_guess], user_guess 
  else
    "Please enter a number 1-20"
  end
end

def compare_guesses computer_guess, user_guess
  if user_guess == computer_guess
    session[:server_guess] = random_num
    session[:turns] = 0
    "User wins! Enter a number to play again!"
  elsif user_guess.between?(computer_guess, computer_guess+3) || user_guess.between?(computer_guess-3, computer_guess)
    "You're close!"
  else
    "You're cold!"
  end
end
