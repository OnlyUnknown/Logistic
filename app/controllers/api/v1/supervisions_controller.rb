class Api::V1::SupervisionsController < ApplicationController
  def index
    @supervision = Supervision.all
    if @supervision
      render json: @supervision
    else
      render json: @supervision.errors.full_messages
    end
  end
end
