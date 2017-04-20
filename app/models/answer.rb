class Answer < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  validates :comment, null:false
  validates :user_id, null:false
  validates :question_id, null:false

    belongs_to :user
    belongs_to :question

    has_many :answer_votes, dependent: :destroy



end
