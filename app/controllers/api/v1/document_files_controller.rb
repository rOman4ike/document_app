class Api::V1::DocumentFilesController < ApplicationController
  load_and_authorize_resource
  before_action :set_document_file, only: %i[ destroy ]

  def destroy
    @document_file.soft_destroy
  end

  private
    def set_document_file
      @document_file = DocumentFile.find(params[:id])
    end

    def document_file_params
      params.require(:document_file).permit!
    end
end
