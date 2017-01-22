class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    @applicant.workflow_state = 'applied'
    if @applicant.save
      flash[:notice] = 'Application submitted! Edit you application below'
      redirect_to action: 'edit', id: @applicant
    else
      flash.now[:errors] = @applicant.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @applicant = Applicant.find(params[:id])
  end

  def update
    @applicant = Applicant.find(params[:id])
    if @applicant.update_attributes(article_params)
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  private

  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :phone,
                                      :phone_type, :workflow_state, :region)
  end
end
