class Api::V1::DocTagsController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource
  before_action :set_doc_tag, only: %i[ update destroy ]

  def index
    doc_tags = DocTag.all
    doc_tags = doc_tags.search_by_title(params[:title]) if params[:title].present?
    @pagy, @doc_tags = pagy(doc_tags, page: params[:page], items: 20)
  end

  def create
    @doc_tag = DocTag.new(doc_tag_params)
    if @doc_tag.save
      render :create
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def update
    if @doc_tag.update(doc_tag_params)
      render :update
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def destroy
    if !@doc_tag.destroy
      render :errors, status: :unprocessable_entity
    end
  end

  private
    def set_doc_tag
      @doc_tag = DocTag.find(params[:id])
    end

    def doc_tag_params
      params.require(:doc_tag)
        .permit!
        .except(:null)
    end
end
