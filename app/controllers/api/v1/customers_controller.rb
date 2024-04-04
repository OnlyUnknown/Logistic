class Api::V1::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:index]
  def profile
    @customer = current_customer
    if @customer
      render json: @customer
    else
      render json: @customer.errors.full_messages
    end
  end
end
