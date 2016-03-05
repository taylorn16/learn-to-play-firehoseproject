class Instructor::CoursesController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_current_course, only: [:show]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)

    if @course.valid?
      return redirect_to instructor_course_path(@course)
    else
      return render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def authorize_current_course
    unless current_course.user == current_user
      return render text: "Unauthorized", status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost)
  end

end
