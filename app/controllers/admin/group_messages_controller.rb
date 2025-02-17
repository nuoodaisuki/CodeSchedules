class Admin::GroupMessagesController < Admin::ApplicationController

  before_action :set_group

  # グループ内メッセージ一覧表示
  def index
    @group_messages = @group.group_messages
  end

  # メッセージ削除
  def destroy
    @group_message = @group.group_messages.find(params[:id])
    if @group_message.destroy
      redirect_to admin_group_group_messages_path(@group), notice: "メッセージを削除しました。"
    else
      redirect_to admin_group_group_messages_path(@group), alert: "メッセージの削除に失敗しました。"
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

end
