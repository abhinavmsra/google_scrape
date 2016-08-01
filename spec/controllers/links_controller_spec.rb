require 'rails_helper'

RSpec.describe LinksController, type: :controller do

  describe 'GET #index' do
    let(:count) { Faker::Number.between(1, 5)}
    let(:word) { Faker::Lorem.word }
    let(:url) { Faker::Internet.url("#{word}.com", '/foobar.html') }

    before(:each) do
      count.times { create(:link, url: url) }
    end

    it 'should return the query results' do
      query = { contains: word, url: url, path_depth: 1 }
      get :index, params: query
      expect(json_response[:links].count).to eq(count)
    end
  end

  describe 'GET #query' do
    it 'should render the query template' do
      get :query
      expect(response).to render_template('links/query')
    end
  end
end
