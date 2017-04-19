#returns a new HTML question form
get '/questions/:id/answers/new' do
  @question = Question.find(params[:id])
  erb :'questions/show'
end

#create a new answer
post '/questions/:id/answers' do
  @answer = Answer.new(params[:answer])
  @answer.user_id = current_user.id
  @answer.question_id = params[:id]
    if @answer.save
      flash[:msg] = "Succesfully answered question"
      redirect '/questions'
    else
      flash[:msg] = @answer.errors.full_messages.join(',')
      redirect ':/questions/:id/answers/new'
    end
end
