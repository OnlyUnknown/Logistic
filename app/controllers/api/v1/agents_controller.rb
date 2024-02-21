class Api::V1::AgentsController < ApplicationController
  def index
    @agent = Agent.find(params[:id])
    if @agent
      render json: @agent
    else
      render json: @agent.errors.full_messages
    end
  end
end
