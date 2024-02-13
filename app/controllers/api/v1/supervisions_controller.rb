class Api::V1::SupervisionsController < ApplicationController
  def index
    @supervision = Supervision.find(params[:id])
    if @supervision
      render json: @supervision
    else
      render json: @supervision.errors.full_messages
    end
  end

  def create
    @supervision = Supervision.new(supervision_params)

    if @supervision.save
      redirect_to @supervision
    else
      render 'new'
    end
  end

  private

  def supervision_params
    params.require(:supervision).permit(:supervisor_id, :agent_id)
  end
end
