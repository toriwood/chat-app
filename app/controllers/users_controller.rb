class UsersController < ApplicationController
  def index
    @users = User.all
  end

  private
    def permitted_params
      params.require(:user).permit(:id)
    end
end
