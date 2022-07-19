require 'sinatra'
require 'sinatra/reloader'

enable :sessions

get '/' do
  erb(:root)
end

post '/start' do
  erb(:login)
end

get '/start' do
  @loginfailure = false
  erb(:login)
end

post '/authenticate' do
  @user = params[:username]
  @pass = params[:password]
  if @user == "swethavraj" && @pass == "letmein"
    session[:user] = @user
    session[:totalwin] = 0
    session[:totalloss] = 0
    session[:totalprofit] = 0
    session[:totalmoney] = 0
    session[:notbetted] = true
    erb(:result)
  else
    @loginfailure = true
    erb(:login)
  end
end

post '/submit' do
  unless session[:user]
    redirect('/start')
  end
  session[:notbetted] = false
  @money = params[:betmoney].to_i
  @bet = params[:bet].to_i
  @dice = rand(6) + 1
  session[:resultmoney] = @money
  @notvalidbet = @bet == 0 || @money == 0
  if @notvalidbet
    erb(:result)
  end
  if @dice == @bet
    session[:resultmoney] = 10 * @money
    session[:totalwin] += session[:resultmoney]
    session[:result] = "won"
  else
    session[:totalloss] += @money
    session[:result] = "lost"
  end
  session[:totalprofit] = session[:totalwin] - session[:totalloss]
  erb(:result)
end

post '/logout' do
  session[:user] = ""
  session[:logoutmessage] = "you are successfully logged out"
  redirect('/start')
end

not_found do
  erb(:notfound)
end