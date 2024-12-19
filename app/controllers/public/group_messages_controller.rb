class Public::GroupMessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user
  
  # メッセージ一覧表示
  def index
    @group = Group.find(params[:group_id])
    @group_messages = @group.group_messages.includes(:user).order(:created_at)
    @group_message = @group.group_messages.new
  end

  # メッセージ作成
  def create
    @group = Group.find(params[:group_id])
    @group_message = @group.group_messages.new(group_message_params)
    @group_message.user = current_user
    if @group_message.save
      redirect_to group_group_messages_path(@group), notice: 'メッセージを送信しました。'
    else
      @group_messages = @group.group_messages.includes(:user).order(:created_at)
      flash.now[:alert] = "メッセージを入力して下さい。"
      render :index
    end
  end

  # メッセージ編集画面表示
  def edit
    @group = Group.find(params[:group_id])
    @group_message = @group.group_messages.find(params[:id])
  end

  # メッセージ更新
  def update
    @group = Group.find(params[:group_id])
    @group_message = @group.group_messages.find(params[:id])
    if @group_message.update(group_message_params)
      redirect_to group_group_messages_path(@group), notice: 'メッセージが更新されました。'
    else
      flash.now[:alert] = "メッセージを入力して下さい。"
      render :edit
    end
  end

  # メッセージ削除
  def destroy
    @group = Group.find(params[:group_id])
    @group_message = @group.group_messages.find(params[:id])
    @group_message.destroy
    redirect_to group_group_messages_path(@group), notice: 'メッセージが削除されました。'
  end

  private

  def group_message_params
    params.require(:group_message).permit(:content)
  end

  def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , alert: "ゲストユーザーはメッセージ機能を使えません。"
    end
  end

end
