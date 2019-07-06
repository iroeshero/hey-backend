class MembersController < ApplicationController
    before_action :authorize_request, except: [:create, :index]
    before_action :find_member, except: %i[create index]

    before_action :authenticate_user!, except: :create
    before_action :set_page_details


    def index
        @members = Member.all

        #render json: @members, status: :ok
    end

    def show
        render json: @member, status: :ok
      end

    def create
        @member = Member.new(member_params)
        if @member.save
            render json: @member, status: :created
        else
            render json: { errors: @member.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def set_page_details
        $page_name = "Members"
        $sub_page_name = "List of Members"
    end

    def find_member
        @member = Member.find_by_username!(params[:_username])
        rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Member not found' }, status: :not_found
    end

    def member_params
        params.permit(
          :username, :email, :password, :password_confirmation, :firstname, :lastname
        )
    end
end