class Admin::GroupsController < ApplicationController

  before_action :authenticate_admin!

  # グループ一覧表示
  def index
    @groups = Group.all
  end

  # グループ削除
  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      redirect_to admin_groups_path, notice: "グループを削除しました。"
    else
      redirect_to admin_groups_path, alert: "グループの削除に失敗しました。"
    end
  end

end
