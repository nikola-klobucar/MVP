class UsersController < ApplicationController
    before_action :set_user, only: [:show]

    def show
        if current_user != @user
            redirect_to new_user_session_path
        end
    end


    private
        def set_user
            @user = User.find(params[:id])
            rescue ActiveRecord::RecordNotFound
                flash[:alert] = "Stranica koju ste zatražili ne postoji"
                redirect_to current_user
        end
end
