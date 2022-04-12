class Api::WorkExperiencesController < Api::BaseController
  before_action :fetch_profile
  before_action :fetch_work_experience, except: [:index, :create]

  def index
    work_experiences = @profile.work_experiences
    render json: { work_experiences: work_experiences }
  end

  def show
    render json: { work_experience: @work_experience }
  end

  def create
    work_experience = @profile.work_experiences.create(work_experience_params)
    if work_experience.id
      render json: { work_experience: work_experience }, status: :created
    else
      render json: { errors: work_experience.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @work_experience.update(work_experience_params)
      render json: { work_experience: @work_experience }
    else
      render json: { errors: @work_experience.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @work_experience.destroy
      render json: { work_experience: @work_experience }
    else
      render json: { error: 'Can not delete' }, status: :unprocessable_entity
    end
  end

  private

  def fetch_work_experience
    @work_experience = @profile.work_experiences.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def fetch_profile
    @profile = current_user.profile
  end

  def work_experience_params
    params.require(:work_experience).permit(:title, :employer, :starts_on, :ends_on, :is_present, :description)
  end
end
