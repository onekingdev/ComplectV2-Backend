class ArchivedPolicyService
  def initialize(is_archived, policy, user)
    @is_archived = is_archived
    @policy = policy
    @user = user
  end

  def process
    @policy.update(update_params)
    @policy
  end

  private

  def update_params
    status = @is_archived ? Policy.statuses['archived'] : Policy.statuses['draft']
    archived_at = @is_archived ? Time.current : nil
    archived_by = @is_archived ? @user : nil
    { status: status, archived_at: archived_at, archived_by: archived_by }
  end
end
