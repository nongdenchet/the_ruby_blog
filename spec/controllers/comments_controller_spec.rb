# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  article_id :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      @user = create(:user)
      @article = create(:article, user: @user)
    end

    context "user not login" do
      it "should not create comment when not login" do
        post :create, {content: 'this is a comment', article_id: @article.id}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user login" do
      before(:each) do
        sign_in @user
        @params = {comment: {content: 'this is a comment', article_id: @article.id}}
      end

      it "shold create comment" do
        expect {
          post :create, @params
        }.to change(Comment, :count).by(1)
        expect(Comment.first.user).to eq(@user)
        expect(Comment.first.article).to eq(@article)
      end

      it "should redirect to article" do
        post :create, @params
        expect(response).to redirect_to @article
      end
    end
  end
end
