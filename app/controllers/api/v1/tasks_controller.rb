class Api::V1::TasksController < ApplicationController
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
