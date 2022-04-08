class RiskPolicy < ApplicationRecord
  belongs_to :risk
  belongs_to :policy
end
