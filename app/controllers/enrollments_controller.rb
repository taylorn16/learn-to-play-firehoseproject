class EnrollmentsController < ApplicationController

  before_action :authenticate_user!

  def create
    enrollment = Enrollment.new
    enrollment.course_id = current_course.id
    enrollment.user_id = current_user.id

    if current_course.premium?              # Only run stripe API if the course costs money
      customer = Stripe::Customer.create(
        :email => current_user.email,
        :card => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => (current_course.cost * 100).to_i,
        :description => "Learn to Play App Premium Content - #{current_course.title}",
        :currency => 'usd'
      )
    end

    if enrollment.save
      return redirect_to course_path(current_course)
    else
      return render text: "Enrollment didn't save properly.", status: :internal_server_error
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def enrollment_params
    params.require(:enrollment).permit(:course_id, :user_id)
  end

end
