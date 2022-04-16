class Api::PoliciesController < Api::BaseController
  before_action :fetch_policy, except: [:index, :create, :update_position]

  def index
    policies = Policy.root
    render json: { policies: policies }
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
    PublishPolicyService.new(policy_params, @policy, current_user).process
    render json: { policy: @policy }
  end

  def archived
    render json: { error: I18n.t("policies.errors.unable_to_process") },
           status: :unprocessable_entity and return if params[:archived].nil?

    policy = ArchivedPolicyService.new(params[:archived], @policy, current_user).process

    if policy.errors.blank?
      render json: { policy: policy }
    else
      render json: { errors: policy.errors }, status: :unprocessable_entity
    end
  end

  def update_position
    if params[:positions].present?
      params[:positions].each do |item|
        policy = Policy.find_by(id: item['id'])
        policy&.update_attribute('position', item['position'])
      end
      render json: { message: 'success' }
    else
      render json: { message: 'error' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @policy.destroy
      render json: { policy: @policy }
    else
      render json: { error: I18n.t("policies.errors.unable_to_destroy") }, status: :unprocessable_entity
    end
  end

  private

  def fetch_policy
    @policy = Policy.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def policy_params
    params.require(:policy).permit(:name, :description, :status)
  end
end
