class Api::RisksController < Api::BaseController
  before_action :fetch_risk, only: [:show, :update, :destroy]

  def index
    risks = Risk.all
    render json: { risks: risks }
  end

  def show
    render json: { risk: @risk }
  end

  def create
    risk = Risk.new(risk_params.merge(user: current_user, updated_by: current_user))
    if risk.save
      render json: { risk: risk }, status: :created
    else
      render json: { errors: risk.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @risk.update(risk_params.merge(updated_by: current_user))
      render json: { risk: @risk }
    else
      render json: { errors: @risk.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @risk.destroy
      render json: { risk: @risk }
    else
      render json: { error: I18n.t("risks.errors.unable_to_destroy") }, status: :unprocessable_entity
    end
  end

  private

  def fetch_risk
    @risk = Risk.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def risk_params
    params.require(:risk).permit(:name, :impact, :likelihood, :level, policy_ids: [])
  end
end
