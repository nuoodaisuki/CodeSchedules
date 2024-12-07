# app/controllers/admin/application_controller.rb
class Admin::ApplicationController < ApplicationController

  before_action :authenticate_admin! # 管理者ログインが必要
  
end
