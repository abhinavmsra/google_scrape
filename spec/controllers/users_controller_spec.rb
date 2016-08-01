require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET#index' do
    context 'when user is not logged in' do
      it 'should render the login page' do
        get :index
        expect(response).to render_template('users/_sign_in')
      end
    end

    context 'when user is logged in' do
      it 'should render the dashboard' do
        user =  create :user
        get :index, session: {user_id: user.id}
        expect(response).to render_template('users/_dashboard')
      end
    end
  end
end
