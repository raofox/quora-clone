class AnswerVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!

    validates :user_id, null:false

    belongs_to :user
    belongs_to :answer

end
