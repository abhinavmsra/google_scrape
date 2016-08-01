require 'rails_helper'

RSpec.describe ScrapeWorker, type: :worker do

  describe '#perform' do
    let(:user) { create :user }

    it 'should create a new search result' do
      VCR.use_cassette('synopsis') do
        expect {
          ScrapeWorker.new.perform('coffee house in new york', user.id)
        }.to change(SearchResult, :count).by(1)
      end
    end

    it 'should create new links for the search_result' do
      old_link_count = Link.count
      VCR.use_cassette('synopsis') do
        ScrapeWorker.new.perform('coffee house in new york', user.id)
      end
      new_link_count = Link.count
      expect(SearchResult.last.links.count).to eq(new_link_count - old_link_count)
    end
  end
end
