class Api::V1::ActivityAreasController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource
  before_action :set_acitivity_area, only: %i[ update destroy ]

  def index
    activity_areas = ActivityArea.all
    activity_areas = activity_areas.search_by_title(params[:title]) if params[:title].present?
    @pagy, @activity_areas = pagy(activity_areas, page: params[:page], items: 20)
  end

  def create
    @activity_area = ActivityArea.new(activity_area_params)
    if @activity_area.save
      render :create
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def update
    if @activity_area.update(activity_area_params)
      render :update
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def destroy
    if !@activity_area.destroy
      render :errors, status: :unprocessable_entity
    end
  end

  private
    def set_acitivity_area
      @activity_area = ActivityArea.find(params[:id])
    end

    def activity_area_params
      params.require(:activity_area)
        .permit!
        .except(:null)
    end
end
