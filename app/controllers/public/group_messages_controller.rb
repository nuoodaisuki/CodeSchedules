class Public::GroupMessagesController < Public::ApplicationController

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
    @group_message.save
    @group_messages = @group.group_messages.includes(:user).order(:created_at)
  end

  # メッセージ削除
  def destroy
    @group = Group.find(params[:group_id])
    @group_message = @group.group_messages.find(params[:id])
    @group_message.destroy
    @group_messages = @group.group_messages.includes(:user).order(:created_at)
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
