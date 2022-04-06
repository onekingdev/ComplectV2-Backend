class Api::ExamsController < Api::BaseController
  before_action :fetch_exam, except: [:create, :index]

  def index
    @exams = current_user.exams
    render json: { exams: @exams }
  end

  def show
    render json: { exam: @exam }
  end

  def create
    exam = Exam.new(exam_params.merge(user: current_user, updated_by: current_user))
    if exam.save
      render json: { exam: exam }, status: :created
    else
      render json: { errors: exam.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @exam.update(exam_params.merge(updated_by: current_user))
      render json: { exam: @exam }
    else
      render json: { errors: @exam.errors }, status: :unprocessable_entity
    end
  end

  def completed
    completed_at = params[:completed] ? Time.current : nil
    if @exam.update(completed_at: completed_at, updated_by: current_user)
      render json: { status: :ok, exam: @exam }
    else
      render json: { status: :unprocessable_entity, errors: @exam.errors }
    end
  end

  def destroy
    if @exam.destroy
      render json: { exam: @exam }
    else
      render json: { error: 'Can not delete' }, status: :unprocessable_entity
    end
  end

  private

  def fetch_exam
    @exam = Exam.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def exam_params
    params.require(:exam).permit(:name, :starts_on, :ends_on)
  end
end
