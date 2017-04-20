class QuestionVotes < ActiveRecord::Migration
	def change
		create_table :question_votes do |t|
		t.integer :user_id
		t.integer :question_id
		t.boolean :vote
		t.timestamps
		end
	end
end