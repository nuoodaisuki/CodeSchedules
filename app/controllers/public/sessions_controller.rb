# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def create
    self.resource = warden.authenticate(auth_options)

    # 認証失敗時のカスタマイズ
    if resource.nil?
      if params[:user][:email].present? && params[:user][:password].present?
        flash[:alert] = "メールアドレスまたはパスワードが間違っています。"
      else
        flash[:alert] = "メールアドレスまたはパスワードが入力されていません。"
      end
      redirect_to new_user_session_path and return
    end

    super # 認証成功時は通常の挙動
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(current_user), notice: "ゲストユーザーでログインしました。"
  end

  protected

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    user_path(current_user) # 投稿一覧ページ
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    about_path # About ページ
  end

end
