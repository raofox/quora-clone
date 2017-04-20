class AnswerVotes < ActiveRecord::Migration
	def change
		create_table :answer_votes do |t|
		t.integer :user_id
		t.integer :answer_id
		t.boolean :vote
		t.timestamp
		end
	end
end
