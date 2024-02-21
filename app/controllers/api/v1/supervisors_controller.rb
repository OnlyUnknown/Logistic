class Api::V1::SupervisorsController < ApplicationController
  def index
    @supervisor = Supervisor.find(params[:id])
    if @supervisor
      render json: @supervisor
    else
      render json: @supervisor.errors.full_messages
    end
  end
end
