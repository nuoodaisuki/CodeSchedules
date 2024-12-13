class Public::UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    if @user == current_user
      # 自分自身の場合：すべての投稿を取得
      @posts = @user.posts.order(created_at: :desc)
    else
      # 他ユーザーの場合：完了した投稿のみ取得
      @posts = @user.posts.where(is_completion: true)
    end
  end

  def edit
    ensure_correct_user
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました"
    else
      flash.now[:alert] = "必要な情報を入力して下さい。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      reset_session
      flash[:notice] = "退会処理が完了しました。"
      redirect_to root_path
    else
      redirect_to user_path(@user), alert: "退会処理に失敗しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :email, :image, :introduction).tap do |user_params|
      if params[:user][:encrypted_password].present?
        user_params[:encrypted_password] = params[:user][:encrypted_password]
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
