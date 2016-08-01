require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'POST #create' do
    context 'when the user is not logged in' do
      it 'should redirect to root' do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is logged in' do
      let(:user) { create :user }

      context 'with valid data' do
        let(:base64_text) {'data:text/csv;base64,Y29mZmVlIGhvdXNlIGluIG5ldyB5b3Jr' }

        it 'should return success message' do
          VCR.use_cassette('search') do
            post :create, params: {data: base64_text}, session: {user_id: user.id}
            expect(json_response[:status]).to eq('success')
          end
        end

        it 'should respond with 200' do
          VCR.use_cassette('search') do
            post :create, params: {data: base64_text}, session: {user_id: user.id}
            expect(response.status).to eq(200)
          end
        end
      end

      context 'with invalid data' do
        let(:base64_text) {'data:text/csv;base64,Y29mZmVlIGhvdXNlIGluIG5l345dwertyB5b3Jr' }

        it 'should return error message' do
          VCR.use_cassette('search') do
            post :create, params: {data: base64_text}, session: {user_id: user.id }
            expect(json_response[:status]).to eq('error')
          end
        end

        it 'should respond with 400' do
          VCR.use_cassette('search') do
            post :create, params: {data: base64_text}, session: {user_id: user.id}
            expect(response.status).to eq(400)
          end
        end
      end
    end
  end
end
