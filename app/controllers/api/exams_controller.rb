class Api::ExamsController < ApplicationController
  before_action :fetch_exam, except: [:create, :index]

  def index
    @exams = Exam.all
    render json: { exams: @exams }
  end

  def show
    render json: { exam: @exam }
  end

  def create
    exam = Exam.new(exam_params)
    if exam.save
      render json: { exam: exam }, status: :created
    else
      render json: { errors: exam.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @exam.update(exam_params)
      render json: { exam: @exam }
    else
      render json: { errors: @exam.errors }, status: :unprocessable_entity
    end
  end

  def completed
    completed_at = params[:completed] ? Time.current : nil
    if @exam.update(completed_at: completed_at)
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
    params.require(:exam).permit(:name, :starts_on, :ends_on, :user_id, :updated_by_id)
  end
end
