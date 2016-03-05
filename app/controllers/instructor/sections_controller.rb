class Instructor::SectionsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_current_course

  def new
    @section = Section.new
  end

  def create
    @section = current_course.sections.create(section_params)

    return redirect_to instructor_course_path(current_course)
  end

  private

  def authorize_current_course
    unless current_course.user == current_user
      return render text: "Unauthorized", status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def section_params
    params.require(:section).permit(:title)
  end

end
