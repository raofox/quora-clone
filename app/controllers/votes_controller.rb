#click on downvote button for QUESTIONS!!
post '/questions/:id/votes' do

@votes = Question.find(params[:id]).question_votes
current_user_vote = @votes.find_by(user_id: current_user.id)
  if current_user_vote.nil?
    # the user has not voted before
    @vote = QuestionVote.new(vote: true, user_id: current_user.id, question_id: params[:id])
    @vote.save
    flash[:msg] = "Downvoted!!"
    redirect '/questions'
  else
    if current_user_vote.vote
      current_user_vote.update(vote: false)
      flash[:msg] = "Removed downvote"
    elsif !current_user_vote.vote
      current_user_vote.update(vote: true)
      flash[:msg] = "Downvoted"
    end
    redirect '/questions'
  end
end

#click on upvote button for ANSWERS!!
post '/answers/:id/upvote' do
@answer = Answer.find(params[:id])
@votes = @answer.answer_votes
current_user_vote = @votes.find_by(user_id: current_user.id)
  if current_user_vote.nil?
    # the user has not voted before
    @vote = AnswerVote.new(vote: true, user_id: current_user.id, answer_id: params[:id])
    @vote.save
    flash[:msg] = "Upvoted!!"
    redirect "/questions/#{@answer.question_id}"
  else
    if current_user_vote.vote == false
      current_user_vote.delete
      @vote = AnswerVote.new(vote: true, user_id: current_user.id, answer_id: params[:id])
      @vote.save
    elsif current_user_vote.vote == true
      current_user_vote.delete
    end
  end
    redirect "/questions/#{@answer.question_id}"
end

#click on downvote button for ANSWERS!!
post '/answers/:id/downvote' do

@answer = Answer.find(params[:id])
@votes = @answer.answer_votes
current_user_vote = @votes.find_by(user_id: current_user.id)
  if current_user_vote.nil?
    # the user has not voted before
    @vote = AnswerVote.new(vote: false, user_id: current_user.id, answer_id: params[:id])
    @vote.save
    flash[:msg] = "Downvoted!!"
    redirect "/questions/#{@answer.question_id}"
  else
    if current_user_vote.vote == true
      current_user_vote.delete
      @vote = AnswerVote.new(vote: false, user_id: current_user.id, answer_id: params[:id])
      @vote.save
    elsif current_user_vote.vote == false
      current_user_vote.delete
    end
  end
    redirect "/questions/#{@answer.question_id}"
end
