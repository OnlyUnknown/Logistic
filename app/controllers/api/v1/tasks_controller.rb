class Api::V1::TasksController < ApplicationController
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  def show_task
    @task = Task.where(id: params[:id])
    render json: @task, except: [:confirmation_code]
  end

  private

  def generate_task_id
    loop do
      random_id = SecureRandom.alphanumeric(12).upcase
      break self.id = random_id unless Task.exists?(id: random_id)
    end
  end

  def task_params
    params.require(:task).permit(:supervisor_id, :product, :sender, :quantity, :receiver, :status, :price,
                                 :current_location, :total)
  end
end
