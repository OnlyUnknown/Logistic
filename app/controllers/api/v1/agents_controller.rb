class Api::V1::AgentsController < ApplicationController
  before_action :authenticate_agent!, only: [:accept_task]
  
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
    @task.update(agent_id: current_agent, status: "on delivery")

    render json: { message: 'Task accepted successfully' }
  end

  private

  def check_supervision(supervisor_id)
    return if Supervision.exists?(supervisor_id:supervisor_id, agent_id:current_agent.id)

    raise ActiveRecord::RecordNotDestroyed, "The agent isn't in your supervision"
  end

end
