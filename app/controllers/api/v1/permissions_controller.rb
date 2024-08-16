class Api::V1::PermissionsController < ApplicationController
  load_resource :permission

  def index
    @permissions = Permission.all.sort_by(&:user_fullname)
  end

  def create
    @permission = Permission.new(permission_params)
    if @permission.save
      render :create
    else
      render :errors
    end
  end

  def destroy
    @permission.destroy
  end

  def available_roles
    render json: { available_roles: Permission.available_roles_with_locales }
  end

  private
    def permission_params
      params.require(:permission).permit(:user_id, :fullname, :role, :context_type, :context_id)
    end
end
