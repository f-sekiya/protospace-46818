class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_prototype, only: :create

  def create
    @comment = Comment.new(comment_params)
    @comments = @prototype.comments.includes(:user)
    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private
  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
