class Api::RegulatoryBodiesController < Api::BaseController
  def index
    render json: ActsAsTaggableOn::Tag.all.collect(&:name)
  end
end
