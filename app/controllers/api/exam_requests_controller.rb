class Api::ExamRequestsController < Api::BaseController
  before_action :fetch_exam
  before_action :fetch_exam_request, only: [:update, :destroy]

  def create
    exam_request = @exam.exam_requests.create(exam_request_params.merge(user: current_user, updated_by: current_user))
    if exam_request.id
      render json: { exam_request: exam_request }, status: :created
    else
      render json: { errors: exam_request.errors }, status: :unprocessable_entity
    end
  end

  def update
    params = exam_request_params.to_h
    params.merge!(shared_by: current_user) if update_shared?

    if @exam_request.update(params.merge(updated_by: current_user))
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

  def fetch_exam
    @exam = Exam.find(params[:exam_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def fetch_exam_request
    @exam_request = @exam.exam_requests.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.to_s }, status: :not_found
  end

  def exam_request_params
    params.require(:exam_request).permit(:name, :details, :shared, text_items: [])
  end

  def update_shared?
    !exam_request_params[:shared].nil? && exam_request_params[:shared] != @exam_request.shared
  end
end
