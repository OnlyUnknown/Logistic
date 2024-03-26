class Api::V1::AgentsController < ApplicationController
  before_action :authenticate_agent!, only: [:accept_task, :remove_task]
  
  def index
    @agent = Agent.find(params[:id])
    if @agent
      render json: @agent
    else
      render json: @agent.errors.full_messages
    end
  end

  def accept_task
    @task = Task.find(params[:id])
    check_supervision(@task.supervisor_id)
    
    if @task.agent_id.nil?
       @task.update(agent_id: current_agent.id, status: "on delivery")
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
    else
      if current_agent.id == @task.agent_id
        @task.update(agent_id: nil, status: "pending") 
        render json: { message: 'Task removed successfully' }
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  private

  def check_supervision(supervisor_id)
    return if Supervision.exists?(supervisor_id:supervisor_id, agent_id:current_agent.id)

    raise ActiveRecord::RecordNotDestroyed, "The agent isn't in your supervision"
  end

end
