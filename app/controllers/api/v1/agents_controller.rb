class Api::V1::AgentsController < ApplicationController
  def show
    @agent = Agent.all
    if @agent
      render json: @agent
    else
      render json: @agent.errors.full_messages
    end
  end
end
