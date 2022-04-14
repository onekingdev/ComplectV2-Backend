class Api::BaseController < ApplicationController
  include ::Pundit
  before_action :authenticate_user!
  respond_to :json

  def authorize_action(policy = nil)
    authorize request.headers['HTTP_BUSINESS_ID'].to_i, policy_class: policy if policy
  end
end
