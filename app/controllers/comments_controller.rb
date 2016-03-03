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

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    current_user.comments.create(comment_params)
    redirect_to "/articles/#{params[:comment][:article_id]}"
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end
end
