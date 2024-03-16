class Api::V1::SupervisorsController < ApplicationController
  before_action :authenticate_supervisor!, only: [:create_task]
  def index
    @supervisor = Supervisor.find(params[:id])
    if @supervisor
      render json: @supervisor
    else
      render json: @supervisor.errors.full_messages
    end
  end
  def create_task
    @new_task = Task.create()
  end
end
