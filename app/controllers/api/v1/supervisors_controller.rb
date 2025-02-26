class Api::V1::SupervisorsController < ApplicationController
  before_action :authenticate_supervisor!, only: %i[create_task
                                                    delete_task update_task]
  def profile
    @supervisor = current_supervisor
    if @supervisor
      render json: @supervisor
    else
      render json: { error: 'Supervisor not found' }, status: :not_found
    end
  end

  def update_supervisor
    @supervisor = current_supervisor

    if @supervisor.update(supervisoru_params)
      render json: { message: 'supervisor updated successfully' }
    else
      render json: { errors: @supervisor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create_task
    @task = Task.new(task_params)
    check_supervision(@task.agent_id) unless @task.agent_id.nil?
    if @task.save
      render json: @task, except: [:confirmation_code]
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_task
    @task = Task.find(params[:id])

    if @task.update(tasku_params)
      check_supervisor(@task)
      check_supervision(@task.agent_id) unless @task.agent_id.nil?
      render json: { message: 'Task updated successfully' }
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete_task
    @task = Task.find(r_task_params[:task])
    check_supervisor(@task)
    @task.destroy
    render json: { message: 'Task deleted successfully' }
  end

  private

  def supervisoru_params
    params.require(:supervisor).permit(:name, :phone_number,
                                       :email)
  end

  def task_params
    current_supervisor
    random_id = generate_task_id
    current_status = task_status
    random_code = generate_task_code
    params.require(:task).permit(
      :agent_id,
      :customer_id,
      :product,
      :quantity,
      :price,
      :total
    ).merge(
      id: random_id,
      status: current_status,
      supervisor: current_supervisor,
      confirmation_code: random_code
    )
  end

  def tasku_params
    current_status = task_status
    params.require(:task).permit(:agent_id, :customer_id,
                                 :product, :quantity, :price, :total).merge(
                                   status: current_status
                                 )
  end

  def task_status
    if params[:task][:agent_id].nil?
      'pending'
    else
      'on Delivery'
    end
  end

  def generate_task_code
    rand 100_000...999_999
  end

  def generate_task_id
    loop do
      random_id = rand 100_000_000_000...999_999_999_999
      return random_id unless Task.exists?(id: random_id)
    end
  end

  def r_task_params
    params.permit(:task)
  end

  def check_supervision(agent_id)
    return if Supervision.exists?(supervisor_id: current_supervisor.id, agent_id:)

    raise ActiveRecord::RecordNotDestroyed, "The agent isn't in your supervision"
  end

  def check_supervisor(task)
    return if task.supervisor_id == current_supervisor.id

    raise ActiveRecord::RecordNotDestroyed, "You don't have permission to delete this task"
  end
end
