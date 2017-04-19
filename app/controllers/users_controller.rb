#show an HTML form for signingup
get '/signup' do
	erb :'users/new'
end
#post the signup form
post '/signup' do
  @user = User.new(params[:user])
	  if @user.save
			flash[:msg] = "Succesfully signed up. Log in to continue"
	    redirect '/login'
	  else
			flash[:msg] = @user.errors.full_messages.join(',')
	    redirect '/signup'
	  end
end

#show a HTML for for loggingin
get '/login' do
  redirect '/'
end

#post the login form
post '/login' do
  user = User.find_by(email: params[:email])
	if user.nil?
		flash[:msg] = "Invalid email or password"
		redirect '/login'
	end

  if BCrypt::Password.new(user.password) == params[:password]
		flash[:msg] = "Logged in succesfully"
    session[:user_id] = user.id
		redirect '/dashboard'

  else
		flash[:msg] = "Invalid email or password"
		redirect '/login'
  end
end

#psot the logout command
post '/logout' do
  session[:user_id] = nil
	flash[:msg] = "Logged out succesfully"
	redirect '/login'
end

#dispaly the user dashboard
get '/dashboard' do
	erb :'users/dashboard'
end

#get's all user's questions
get '/users/:id' do
  @user = User.find_by_id(params[:id])
end

#routes to show all questions by a particular user
get '/users/:id/questions' do
  if current_user
    @user = User.find(params[:id])
    erb :'users/index'
  else
    flash[:msg] = "Please log in to ask a question"
    redirect '/login'
  end
end

#routes to show all answers by a particular user
get '/users/:id' do
  @user = User.find_by_id(params[:id])
end

get '/users/:id/answers' do
  if current_user
    @user = User.find(params[:id])
		@question = Question.find_by_user_id(session[:id])
    erb :'answers/index'
  else
    flash[:msg] = "Please log in to view all questions"
    redirect '/login'
  end
end
