class Public::CommentsController < Public::ApplicationController

  before_action :set_comment, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_to post_path(@post), notice: "コメントしました。"
    else
      @user = @post.user
      @comments = @post.comments
      render "public/posts/show" # showアクションのビューを再表示
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id]), notice: "コメントを削除しました。"
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@comment.post), notice: "コメントを更新しました。"
    else
      render :edit
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    comment = Comment.find(params[:id])
    unless comment.user == current_user
      redirect_to post_path(comment.post), alert: "他のユーザーのコメントの編集・削除は出来ません。"
    end
  end

end
