class EnrollmentsController < ApplicationController

  before_action :authenticate_user!

  def create
    enrollment = Enrollment.new
    enrollment.course_id = current_course.id
    enrollment.user_id = current_user.id

    if enrollment.save
      return redirect_to course_path(current_course)
    else
      return render text: "Enrollment didn't save properly.", status: :internal_server_error
    end
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def enrollment_params
    params.require(:enrollment).permit(:course_id, :user_id)
  end

end
