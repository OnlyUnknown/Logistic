class Api::V1::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:profile]
  def profile
    @customer = current_customer
    if @customer
      render json: @customer
    else
      render json: @customer.errors.full_messages
    end
  end

  def update_customer
    @customer = current_customer

    if @customer.update(customeru_params)
      render json: { message: 'customer updated successfully' }
    else
      render json: { errors: @customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def customeru_params
    params.require(:customer).permit(:name, :phone_number,
                                     :email)
  end
end
