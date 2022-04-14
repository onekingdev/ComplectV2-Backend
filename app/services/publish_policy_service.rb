class PublishPolicyService
  attr_reader :policy, :user, :policy_params

  def initialize(policy_params, policy, user)
    @policy_params = policy_params
    @policy = policy
    @user = user
  end

  def process
    Policy.transaction do
      policy.update(policy_params.merge(status: Policy.statuses['published'], published_at: Time.current,
                                        updated_by: user, published_by: user))
      create_version
    end
  end

  def create_version
    version_policy = policy.dup
    version_policy.src_id = policy.id
    version_policy.save
  end
end
