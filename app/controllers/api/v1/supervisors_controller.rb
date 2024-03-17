class Api::V1::SupervisorsController < ApplicationController
  before_action :authenticate_supervisor!, only: [:create_task]
  def index
    @supervisor = current_supervisor
    if @supervisor
      render json: @supervisor
    else
      render json: @supervisor.errors.full_messages
    end
  end
  def create_task
    @task = Task.new(task_params)

    if @task.save
      render json: @task
    else
      render 'new'
    end
  end
  private
  
  def task_params
    supervisor = current_supervisor
    params.require(:task).permit(:product, :quantity, :price, :total).merge(status:"pending",supervisor: supervisor)
  end
end
