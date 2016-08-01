require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'when user does not exist' do
      before(:each) do
        request.env['omniauth.auth'] = (FactoryGirl.build :auth_param).stringify_keys
      end

      it 'should create a new user' do
        expect{
          post :create, params: { provider: 'google' }
        }.to change(User, :count).by(1)
      end
    end

    context 'when user exists' do
      before(:each) do
        user = create :user
        request.env['omniauth.auth'] = (FactoryGirl.build :auth_param, uid: user.uid, provider: user.provider).stringify_keys
      end

      it 'should login the user' do
        post :create, params: { provider: 'google' }
        expect(@request.session[:user_id]).to eq(User.last.id)
      end
    end

    context 'when request params are valid' do
      before(:each) do
        request.env['omniauth.auth'] = (FactoryGirl.build :auth_param).stringify_keys
      end

      it 'should redirect to root_path' do
        post :create, params: { provider: 'google' }
        expect(response).to redirect_to(root_path)
      end

      it 'should set the success flash' do
        post :create, params: { provider: 'google' }
        expect(flash[:success]).to be_present
      end
    end

    context 'when request params are invalid' do
      before(:each) do
        request.env['omniauth.auth'] = ''
      end

      it 'should redirect to root_path' do
        post :create, params: { provider: 'google' }
        expect(response).to redirect_to(root_path)
      end

      it 'should set the warning flash' do
        post :create, params: { provider: 'google' }
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create :user }

    before(:each) do
      delete :destroy, session: { user_id: user.id }
    end

    it 'should delete the session' do
      expect(response).to redirect_to(root_path)
    end

    it 'should set the success flash' do
      expect(flash[:success]).to be_present
    end
  end
end
