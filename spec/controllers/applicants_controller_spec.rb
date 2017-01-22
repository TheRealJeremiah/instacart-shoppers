require 'rails_helper'

describe ApplicantsController do
  describe 'GET #show' do
    it 'assigns the requested applicant to @applicant' do
      applicant = create(:applicant)
      get :show, id: applicant
      expect(assigns(:applicant)).to eq(applicant)
    end

    it 'renders the #show view' do
      get :show, id: create(:applicant)
      expect(response).to render_template :show
    end
  end

  describe 'GET #create' do
    it 'assigns the requested applicant to @applicant' do
      applicant = create(:applicant)
      get :show, id: applicant
      expect(assigns(:applicant)).to eq(applicant)
    end

    it 'renders the #show view' do
      get :show, id: create(:applicant)
      expect(response).to render_template :show
    end
  end
end
