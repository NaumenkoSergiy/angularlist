class TasksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  before_filter :find_task, only: [:update, :destroy]

  def index
    respond_with current_user.tasks
  end

  def create
    respond_with current_user.tasks.create(params[:task])
  end

  def update
    respond_with @task.update_attributes(params[:task])
  end

  def destroy
    respond_with @task.destroy
  end

  private

  def find_task
    @task = current_user.tasks.find(params[:id])
  end
end
