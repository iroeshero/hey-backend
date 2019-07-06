class AuthenticationController < ApplicationController

    before_action :authorize_request, except: :login

    # POST /auth/login
    def login
        @member = Member.find_by_email(params[:email])
        if @member&.authenticate(params[:password])
            token = JsonWebToken.encode(member_id: @member.id)
            time = Time.now + 24.hours.to_i
            render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                            username: @member.username }, status: :ok
        else
            render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end

    private

    def login_params
        params.permit(:email, :password)
    end

end