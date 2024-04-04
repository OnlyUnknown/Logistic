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

  def update_task
    @task = Task.find(params[:id])

    if @task.update(tasku_params)
      check_supervisor(@task)
      check_supervision(@task.agent_id) unless @task.agent_id.nil?
      render json: { message: 'Task updated successfully' }
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
