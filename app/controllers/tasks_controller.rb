class TasksController < ApplicationController
  before_action :set_task, except: [:index, :new, :create]

  def index
    @tasks = Task.by_user(current_user.id) + Task.not_user(current_user.id).common
  end

  def new
    @task = Task.new
  end

  def edit
    @sub_task = SubTask.new(task_id: @task.id)

    if current_user != @task.user
      redirect_to tasks_url, notice: 'You do not have permission to edit Tasks from other users .'
    end
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to edit_task_url(@task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :kind).merge(user_id: current_user.id)
  end
end
