class Api::V1::ProfileController < ApplicationController
    before_action :authenticate_supervisor!
   before_action :set_supervisor
    def show
    end

    def follow
        current_supervisor.send_follow_request_to(@supervisor)
        redirect_to profile_path(@supervisor)
    end
    
    def unfollow
        make_it_a_unfriend_request
        current_supervisor.unfollow(@supervisor)
        redirect_to profile_path(@supervisor)
    end

    def accept
        current_supervisor.accept_follow_request_of(@supervisor)
        make_it_a_friend_request
        redirect_to profile_path(@supervisor)
    end

    def decline
        current_supervisor.decline_follow_request_of(@supervisor)
        redirect_to profile_path(@supervisor)
    end

    def cancel
        current_supervisor.remove_follow_request_of(@supervisor)
        redirect_to profile_path(@supervisor)
    end

    private

    def make_it_a_friend_request
        current_supervisor.send_follow_request_to(@supervisor)
        @supervisor.accept_follow_request_of(current_supervisor)
    end

    def make_it_a_unfriend_request
        @supervisor.unfollow(current_supervisor) if @supervisor.mutal_following_with?(current_supervisor)
    end
    def set_supervisor
        @supervisor = Supervisor.find(params[:id])
    end

end
