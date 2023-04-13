class Api::V1::CommentsController < Api::V1::ApplicationController
  def index
    comments = Post.find(params[:post_id]).comments
    render json: comments, status: ok
  end
  
  def create
  end

  prviate
  def comment_params 
  end
end