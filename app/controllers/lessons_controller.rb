class LessonsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_view_lesson, only: [:show]

  def show
  end

  private

  def authorize_view_lesson
    current_course = current_lesson.section.course
    unless current_user.enrolled_in?(current_course)
      flash[:error] = "You must enroll in this course to view its lessons!"
      redirect_to course_path(current_course)
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end
