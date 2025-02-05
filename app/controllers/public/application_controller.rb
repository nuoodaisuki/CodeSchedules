class Public::ApplicationController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user, if: :guest_restricted_controller?

  private

  def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , alert: "ゲストユーザーはこの操作を行えません。"
    end
  end

  def guest_restricted_controller?
    controller_name.in?(%w[comments groups group_users group_messages])
  end

end
