class Api::V1::ChangeOrdersController < ApplicationController
  load_and_authorize_resource
  before_action :set_change_order, only: %i[ destroy ]

  def destroy
    @change_order.soft_destroy
  end

  private
    def set_change_order
      @change_order = ChangeOrder.find(params[:id])
    end

    def change_order_params
      params.require(:change_order).permit!
    end
end
