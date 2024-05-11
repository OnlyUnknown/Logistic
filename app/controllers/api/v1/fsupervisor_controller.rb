class Api::V1::FsupervisorController < ApplicationController
    before_action :authenticate_supervisor!
    before_action :set_user, only: [:add, :is_added]
    
    def add
        if current_supervisor.follow(@user) && @user.follow(current_supervisor)
        render json: { message: "The Agent has been added to the list of the supervision"}
        else
        render json: {message: "Something went wrong"} 
    end
    end

    def is_added
    end

    def remove
    end

    def add_count
        @list = current_supervisor.follow_count
        render json: @list
    end

    private
    def set_user
    @user = Agent.find(params[:id])
    end

end
