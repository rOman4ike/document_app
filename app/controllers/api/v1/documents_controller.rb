class Api::V1::DocumentsController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource
  before_action :set_document, only: %i[ show edit update destroy ]
  before_action :set_paper_trail_whodunnit

  def index
    documents = Document.all
    documents = documents.search_by_title(params[:title]) if params[:title].present?
    documents = documents.search_by_doc_tag_id(params[:doc_tags]) if params[:doc_tags].present?
    documents = documents.filter_by_activity_areas(params[:activity_areas]) if params[:activity_areas].present?
    documents = documents.filter_by_kinds(params[:document_kinds]) if params[:document_kinds].present?
    documents = documents.filter_by_states(params[:document_states]) if params[:document_states].present?
    documents = documents.filter_by_initial_date(params[:initial_date]) if params[:initial_date].present?
    @pagy, @documents = pagy(documents, page: params[:page], items: 20)
  end

  def show
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      render :create
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def update
    if @document.update(document_params)
      render :update
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def destroy
    @document.destroy
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document)
        .permit!
        .except(:null)
    end
end