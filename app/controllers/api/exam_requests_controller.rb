class Api::ExamRequestsController < ApplicationController
  before_action :fetch_exam_request, only: [:update, :destroy]

  def create
    exam_request = ExamRequest.new(exam_request_params)
    if exam_request.save
      render json: { exam_request: exam_request }, status: :created
    else
      render json: { errors: exam_request.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @exam_request.update(exam_request_params)
      render json: { exam_request: @exam_request }
    else
      render json: { errors: @exam_request.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @exam_request.destroy
      render json: { status: :ok }
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private

  def fetch_exam_request
    @exam_request = ExamRequest.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def exam_request_params
    params.require(:exam_request).permit(:name, :details, :shared, :exam_id, :user_id, :updated_by_id, :shared_by_id, text_items: [])
  end
end
