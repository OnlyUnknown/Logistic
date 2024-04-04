class Api::V1::AgentsController < ApplicationController
  before_action :authenticate_agent!,
                only: %i[accept_task remove_task
                 mytasks_list my_supervisors my_supervisors_tasks profile]

  def profile
    @agent = current_agent
    if @agent
      render json: @agent
    else
      render json: @agent.errors.full_messages
    end
  end

  def mytasks_list
    @list = Task.where(agent_id: current_agent.id)
    render json: @list
  end

  def my_supervisors
    @supervisors = Supervision.where(agent_id: current_agent.id).pluck(:supervisor_id)
    @s = Supervisor.where(id: @supervisors).select(:id, :name, :phone_number)
    render json: @s
  end

  def my_supervisors_tasks
    @supervisors = Supervision.where(agent_id: current_agent.id).pluck(:supervisor_id)
    @s = Supervisor.includes(:tasks).where(id: @supervisors).select(:id, :name, :phone_number)
    render json: @s, include: :tasks
  end

  def accept_task
    @task = Task.find(params[:id])
    check_supervision(@task.supervisor_id)

    if @task.agent_id.nil?
      @task.update(agent_id: current_agent.id, status: 'on delivery')
      render json: { message: 'Task accepted successfully' }
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity

    end
  end

  def remove_task
    @task = Task.find(params[:id])
    check_supervision(@task.supervisor_id)

    if @task.agent_id.nil?
      render json: { errors: 'Agent ID is already nil' }, status: :unprocessable_entity
    elsif current_agent.id == @task.agent_id
      @task.update(agent_id: nil, status: 'pending')
      render json: { message: 'Task removed successfully' }
    else
      render json: { errors: 'Something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def check_supervision(supervisor_id)
    return if Supervision.exists?(supervisor_id:, agent_id: current_agent.id)

    raise ActiveRecord::RecordNotDestroyed, "The task isn't under you supervisors"
  end
end
