class Api::PoliciesController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_policy, only: [:show, :update, :destroy]

  def index
    polices = Policy.all
    render json: { polices: polices }
  end

  def show
    render json: { policy: @policy }
  end

  def create
    policy = Policy.new(policy_params.merge(user: current_user, updated_by: current_user))
    if policy.save
      render json: { policy: policy }, status: :created
    else
      render json: { errors: policy.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @policy.update(policy_params.merge(updated_by: current_user))
      render json: { policy: @policy }
    else
      render json: { errors: @policy.errors }, status: :unprocessable_entity
    end
  end

  def published
  end

  def update_position
  end

  def destroy
    if @policy.destroy
      render json: { policy: @policy }
    else
      render json: { error: 'Can not delete' }, status: :unprocessable_entity
    end
  end

  private

  def fetch_policy
    @policy = Policy.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def policy_params
    params.require(:policy).permit(:name, :impact, :likelihood, :level)
  end
end
