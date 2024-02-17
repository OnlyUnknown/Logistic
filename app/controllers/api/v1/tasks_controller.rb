class Api::V1::TasksController < ApplicationController
    def create
        @task = Task.new(task_params)
    
        if @task.save
          redirect_to @task
        else
          render 'new'
        end
      end
    
      private
    
      def task_params
        params.require(:task).permit(:supervisor_id, :product, :sender, :quantity, :receiver, :status, :price, :current_location, :total,)
      end
end
