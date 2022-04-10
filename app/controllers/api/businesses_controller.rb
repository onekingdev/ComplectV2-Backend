class Api::BusinessesController < Api::BaseController
  before_action :get_business

  def update
    if @business.update(business_params)
      render json: @business, serializer: BusinessSerializer
    else
      render json: { errors: @business.errors, status: :unprocessable_entity }
    end
  end

  def show
    respond_with @business, serializer: BusinessSerializer
  end

  private

  def get_business
    @business = current_user.business
  end

  def business_params
    params.require(:business).permit(:business_name, :crd, :aum, :accounts, :time_zone, :phone_number, :website,
                                     :address, :apt_unit, :city, :state, :zipcode, :logo)
  end
end
