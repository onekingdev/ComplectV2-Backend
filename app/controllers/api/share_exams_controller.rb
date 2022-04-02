class Api::ShareExamsController < ApplicationController
  before_action :fetch_exam
  before_action :fetch_share_exam, only: [:destroy]

  def index
    share_exams = @exam.share_exams
    render json: { share_exams: share_exams }
  end

  def create
    share_exam = @exam.share_exams.create(share_exam_params)

    if share_exam.save
      # send email
      render json: { share_exam: share_exam }, status: :created
    else
      render json: { errors: share_exam.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @share_exam.destroy
      render json: { share_exam: @share_exam }
    else
      render json: { error: 'Can not delete' }, status: :unprocessable_entity
    end
  end

  private

  def share_exam_params
    params.require(:share_exam).permit(:invited_email, :user_id)
  end

  def fetch_exam
    @exam = Exam.find(params[:exam_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def fetch_share_exam
    @share_exam = @exam.share_exams.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end
end
