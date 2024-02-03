class Api::V1::CustomersController < ApplicationController
    def index
        @customer = Customer.find(params[:id])
        if @customer
          render json: @customer
        else
          render json: @customer.errors.full_messages
        end
      end
end
