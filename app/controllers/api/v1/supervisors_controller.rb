class Api::V1::SupervisorsController < ApplicationController
  before_action :authenticate_supervisor!, only: [:create_task]
  def index
    @supervisor = current_supervisor
    if @supervisor
      render json: @supervisor
    else
      render json: { error: "Supervisor not found" }, status: :not_found
    end
  end

  def create_task
    @task = Task.new(task_params)

    if @task.save
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete_task
    @task = Task.find(r_task_params[:task])
    check_supervisor(@task)
    @task.destroy
    render json: { message: "Task deleted successfully" }
  end


  private
  
  def task_params
    supervisor = current_supervisor
    random_id = generate_task_id
    current_status = task_status
    params.require(:task).permit(:agent_id, :customer_id, :product, :quantity, :price, :total).merge(id: random_id, status: current_status, supervisor: supervisor)
  end

  def task_status
    if params[:task][:agent_id].nil?
      "pending"
    else
      "on the way"
    end
  end
  def generate_task_id
    loop do
    random_id = rand 100000000000...999999999999
    return random_id unless Task.exists?(id: random_id)
    end
  end

  def r_task_params
    params.permit(:task)
  end

  def check_supervisor(task)
    unless task.supervisor_id == current_supervisor.id
      raise ActiveRecord::RecordNotDestroyed, "You don't have permission to delete this task"
    end
  end
end
