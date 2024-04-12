class Api::V1::SupervisionsController < ApplicationController
  before_action :set_supervision, only: [:show, :destroy]

  def index
    @friends = current_supervisor.friends
  end

  def destroy
    current_supervisor.remove_friend(@supervision.agent)
    head :no_content
  end

  private

  def set_supervision
    @supervision = Supervision.find(params[:id])
  end
end
