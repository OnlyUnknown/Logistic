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
    before_destroy :check_supervisor
    @task = Task.find(r_task).destroy
  end

  private
  
  def task_params
    supervisor = current_supervisor
    random_id = generate_task_id
    params.require(:task).permit(:agent_id, customer_id, :product, :quantity, :price, :total).merge(id: random_id, status: "pending", supervisor: supervisor)
  end

  def generate_task_id
    loop do
      timestamp = rand 100000000000...999999999999
    random_id = "#{timestamp}"
    return random_id unless Task.exists?(id: random_id)
    end
  end

  def check_supervisor
    unless @task.supervisor_id == current_supervisor.id
      errors.add(:base, "You don't have permission to delete this task")
      throw(:abort)
    end
  end
end
