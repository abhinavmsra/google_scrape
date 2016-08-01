require 'rails_helper'

RSpec.describe KeywordsController, type: :controller do
  context 'GET #index' do
    include_examples 'unauthorized'

    context 'when user is logged in' do
      let(:user) { create :user }

      it 'should return a list of keywords' do
        get :index, session: {user_id: user.id}
        expect(assigns(:keywords).count).to eq(SearchResult.count)
      end

      it 'should render the index template' do
        get :index, session: {user_id: user.id}
        expect(response.body).to render_template('keywords/index')
      end
    end
  end

  context 'GET #show' do
    include_examples 'unauthorized'

    context 'when user is logged in' do
      let(:user) { create :user }
      let(:search_result) { create :search_result }

      before(:each) do
        get :show, params: {id: search_result.id}, session: {user_id: user.id}
      end

      it 'should return a list of keywords' do
        expect(assigns(:keyword).id).to eq(search_result.id)
      end

      it 'should render the index template' do
        expect(response.body).to render_template('keywords/show')
      end
    end
  end
end
