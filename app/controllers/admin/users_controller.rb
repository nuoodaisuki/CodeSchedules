class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!  # 管理者ログイン必須

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.where(is_completion: true)  # 完了した投稿のみ表示
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました。"
  end
end
