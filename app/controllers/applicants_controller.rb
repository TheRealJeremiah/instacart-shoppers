class ApplicantsController < ApplicationController
  before_action :require_login, only: [:edit, :update]

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    @applicant.workflow_state = 'applied'
    if @applicant.save
      flash[:notice] = 'Application submitted! Edit you application below'
      login_applicant @applicant
      redirect_to action: 'edit', id: @applicant
    else
      flash.now[:errors] = @applicant.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @applicant = Applicant.find(params[:id])
    redirect_to(new_session_path) unless @applicant == current_applicant
  end

  def update
    @applicant = Applicant.find(params[:id])
    if @applicant.update_attributes(applicant_params)
      flash.now[:notice] = 'Application updated!'
    else
      flash.now[:errors] = @applicant.errors.full_messages.join(', ')
    end
    render 'edit'
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  private

  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone,
                                      :phone_type, :workflow_state, :region)
  end

  def require_login
    redirect_to(new_applicant_path) unless logged_in?
  end
end
