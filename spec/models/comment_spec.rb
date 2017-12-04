require 'rails_helper'

describe Comment do
	describe 'maps a comment type(integer) into a user readable name' do
		before :each do
			@app = App.create(name: 'AFX Dance', description: 'Good!', org_id: 2)
		end
		it 'prints out "general" comment types for an App' do
			@comment = @app.comments.create(commentable: @app, content: 'Good!', user_id: 3, comment_type: 2)
			expect(@comment.comment_type_name).to eq 'general'
		end
		it 'prints out "app_functionality" comment types for an App' do
			@comment = @app.comments.create(commentable: @app, content: 'Good!', user_id: 3, comment_type: 1)
			expect(@comment.comment_type_name).to eq 'app_functionality'
		end
		it 'prints out "contact_status" comment types for an App' do
			@comment = @app.comments.create(commentable: @app, content: 'Good!', user_id: 3, comment_type: 0)
			expect(@comment.comment_type_name).to eq 'contact_status'
		end
	end
end