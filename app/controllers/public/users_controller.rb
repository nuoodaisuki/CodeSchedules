class Public::UsersController < Public::ApplicationController
  
  before_action :ensure_correct_user, only: [:edit]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :favorites]

  def show
    if @user == current_user
      # 自分自身の場合：すべての投稿を取得
      @posts = @user.posts
    else
      # 他ユーザーの場合：完了した投稿のみ取得
      @posts = @user.posts.where(is_completion: true)
    end
    case params[:sort]
    when "いいね数順"
      @posts = @posts.left_joins(:favorites).group(:id).order('COUNT(favorites.id) DESC')
    when "コメント数順"
      @posts = @posts.left_joins(:comments).group(:id).order('COUNT(comments.id) DESC')
    else
      @posts = @posts.order(created_at: :desc) # 新しい順（デフォルト）
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      reset_session
      flash[:notice] = "退会処理が完了しました。"
      redirect_to root_path
    else
      redirect_to user_path(@user), alert: "退会処理に失敗しました。"
    end
  end

  def favorites
    @favorite_posts = @user.favorited_posts.includes(:user).order(created_at: :desc) # 投稿の詳細を取得
  end

  def calendar_posts
    @user = current_user
    @date = Date.parse(params[:date])
    @posts = current_user.posts.where(start: @date.all_day)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :image, :introduction).tap do |user_params|
      if params[:user][:password].present?
        user_params[:password] = params[:user][:password]
      end
    end
  end

  def ensure_correct_user
    user = User.find(params[:id])
    unless user.id == current_user.id && user.email != "guest@example.com"
      redirect_to user_path(current_user)
    end
  end
  
end
