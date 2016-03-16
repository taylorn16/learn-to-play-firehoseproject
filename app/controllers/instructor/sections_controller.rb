class Instructor::SectionsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_current_course, only: [:create]
  before_action :authorize_current_section, only: [:update]

  def create
    @section = current_course.sections.create(section_params)

    return redirect_to instructor_course_path(current_course)
  end

  def update
    # API for AJAX request
    current_section.update_attributes(section_params)
    return render text: 'Updated section!'
  end

  private

  def authorize_current_course
    unless current_course.user == current_user
      return render text: "Unauthorized", status: :unauthorized
    end
  end

  def authorize_current_section
    unless current_section.course.user == current_user
      return render text: "Unauthorized", status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def current_section
    @current_section ||= Section.find(params[:id])
  end

  def section_params
    params.require(:section).permit(:title, :row_order_position)
  end
end
