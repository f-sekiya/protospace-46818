class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comments = @prototype.comments.includes(:user)
  if @comment.save
    redirect_to prototype_path(@comment.prototype)
  else
    @prototype = Prototype.find(comment_params[:prototype_id])
    render "prototypes/show", status: :unprocessable_entity
  end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id,prototype_id: params[:prototype_id])
  end

end
