class DashboardController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    render json: { dashboard: 'yes' }
  end
end