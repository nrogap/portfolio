class UsersController < ApplicationController
  before_action :authorize_request, except: :sign_in

  # POST /users/sign_in
  def sign_in
    @user = User.find_by_username(sign_in_params[:username])

    head :unauthorized if @user.nil?
    head :unauthorized unless @user.authenticate(sign_in_params[:password])

    expire = ENV['TOKEN_EXPIRE_TIME_IN_HOURS'].to_i || 24
    expire_time = expire.hours.from_now
    token = JsonWebToken.encode(user_id: @user.id, exp: expire_time.to_i)

    render json: { token: token, exp: expire_time.strftime('%Y-%m-%d %H:%M%S'),
                   username: @user.username }, status: :ok
  end

  private

  def sign_in_params
    params.permit(:username, :password)
  end
end
