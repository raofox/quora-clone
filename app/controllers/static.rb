get '/' do
  if logged_in?
    redirect '/questions'
  else
  erb :"static/index"
  end
end
