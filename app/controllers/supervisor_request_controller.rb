class SupervisorRequestsController < ApplicationController
    before_action :set_supervisor_request, only: [:show, :destroy]
  
    def index
      @incoming = SupervisorRequest.where(supervisor: current_supervisor)
      @outgoing = current_supervisor.supervisor_requests
    end
  
    def create
      agent = Agent.find(params[:agent_id])
      @supervisor_request = current_supervisor.supervisor_requests.new(agent: agent)
  
      if @supervisor_request.save
        render :show, status: :created, location: @supervisor_request
      else
        render json: @supervisor_request.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @supervisor_request.destroy
      head :no_content
    end
  
    private
  
    def set_supervisor_request
      @supervisor_request = SupervisorRequest.find(params[:id])
    end
  end
  