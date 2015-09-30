require "json"
require 'sinatra' # sinatra to run Ruby backend
enable :sessions # sessions to store computer guess till user guesses the right number

post '/guess' do
  guess = JSON.parse(request.body.read)["guess"].to_i
  result = check_user_guess guess

  puts session[:server_guess] # see what comp guess is for testng
  {result: result}.to_json # create a json obj from hash to send result
end

get '/' do
  session[:server_guess] = random_num # store computer/server guess for session
  erb :index # render erb template on get "/"
end


def random_num 
  comp_num = Random.new
  comp_num.rand(100)
end

def check_user_guess user_guess # validates the user's input and responds, valid or no
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
