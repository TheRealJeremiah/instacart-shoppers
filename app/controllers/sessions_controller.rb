class SessionsController < ApplicationController
  def create
    applicant = Applicant.find_by(email: params[:email])
    if applicant
      login_applicant applicant
      flash[:notice] = "Hello, #{applicant.first_name}!"
      redirect_to edit_applicant_path(applicant)
    else
      flash.now[:error] = 'Email not found'
      render 'new'
    end
  end

  def new
  end
end
