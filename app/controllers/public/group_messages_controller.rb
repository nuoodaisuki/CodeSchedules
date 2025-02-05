class Public::GroupMessagesController < Public::ApplicationController

  before_action :set_group, only: [:index, :create, :destroy]
  
  # メッセージ一覧表示
  def index
    @group_messages = @group.group_messages.includes(:user).order(:created_at)
    @group_message = @group.group_messages.new
  end

  # メッセージ作成
  def create
    @group_message = @group.group_messages.new(group_message_params)
    @group_message.user = current_user
    @group_message.save
    @group_messages = @group.group_messages.includes(:user).order(:created_at)
  end

  # メッセージ削除
  def destroy
    @group_message = @group.group_messages.find(params[:id])
    @group_message.destroy
    @group_messages = @group.group_messages.includes(:user).order(:created_at)
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_message_params
    params.require(:group_message).permit(:content)
  end

end
