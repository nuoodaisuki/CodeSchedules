# app/controllers/admin/tasks_controller.rb
class Admin::TasksController < Admin::ApplicationController

  before_action :set_task, only: [:show, :edit, :update]

  # Task一覧画面
  def index
    @tasks = Task.all
  end

  # Task新規作成画面
  def new
    @task = Task.new
  end

  # Task新規作成処理
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to admin_task_path(@task), notice: 'タスクを作成しました。'
    else
      render :new, alert: 'タスクの作成に失敗しました。'
    end
  end

  # Task詳細画面
  def show
  end

  # Task編集画面
  def edit
  end

  # Task更新処理
  def update
    if @task.update(task_params)
      redirect_to admin_task_path(@task), notice: 'タスクを更新しました。'
    else
      render :edit, alert: 'タスクの更新に失敗しました。'
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  # 許可されたパラメータを指定
  def task_params
    params.require(:task).permit(:name, :explanation)
  end
end
