class Manage::SpaController < ApplicationController
  def index
    gon.jbuilder template: 'app/views/api/v1/shared/_params'
  end
end
