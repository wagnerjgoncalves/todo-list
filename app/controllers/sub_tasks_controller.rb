class SubTasksController < ApplicationController
  before_action :set_task, except: :destroy
  before_action :set_sub_task, only: [:update, :destroy]

  def index
    render json: @task.sub_tasks.order(:description), root: false
  end

  def create
    @sub_task = SubTask.new(create_params)

    if @sub_task.save
      render json: @sub_task
    else
      render json: { errors: @sub_task.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @sub_task && @sub_task.completed!(update_params[:completed])
      Updater::Task.new(@task).mark_as_completed!

      render json: { message: t('messages.updated', scope: :success) }
    else
      render json: { message: t('messages.not_updated', scope: :errors) }, status: :bad_request
    end
  end

  def destroy
    if @sub_task && @sub_task.destroy
      render json: { message: t('messages.destroyed', scope: :success) }
    else
      render json: { message: t('messages.not_destroyed', scope: :errors) }, status: :conflict
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_sub_task
    @sub_task = SubTask.find_by(id: params[:id])
  end

  def create_params
    params.require(:sub_task).permit(:description).merge(task_id: @task.id)
  end

  def update_params
    params.require(:sub_task).permit(:id, :completed)
  end
end
