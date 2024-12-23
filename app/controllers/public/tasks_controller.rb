class Public::TasksController < Public::ApplicationController

  def index
    @tasks = Task.all
  end
  
end
