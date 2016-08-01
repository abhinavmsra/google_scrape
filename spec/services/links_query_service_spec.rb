require 'rails_helper'

RSpec.describe LinksQueryService, type: :service do

  describe '.query' do
    let(:count) { Faker::Number.between(1, 5)}
    let(:word) { Faker::Lorem.word }
    let(:url) { Faker::Internet.url("#{word}.com", '/foobar.html') }

    before(:each) do
      count.times { create(:link, url: url) }
    end

    context 'matching scenarios for' do
      context 'individual query' do
        it 'should return all the records whose url has the word' do
          query = { contains: word }
          response = LinksQueryService.query(query)
          expect(response.count).to eq(count)
        end

        it 'should return all the records whose url matches the url passed' do
          query = { url: url }
          response = LinksQueryService.query(query)
          expect(response.count).to eq(count)
        end

        it 'should return all the records whose url have the required path depth' do
          query = { path_depth: 1 }
          response = LinksQueryService.query(query)
          expect(response.count).to eq(count)
        end
      end

      context 'bulk query' do
        it 'should return all the records that matches the query params' do
          query = { contains: word, url: url, path_depth: 1 }
          response = LinksQueryService.query(query)
          expect(response.count).to eq(count)
        end
      end
    end

    context 'non-matching scenarios' do
      it 'should return no records when word do not match' do
        query = { contains: word * 2, url: url, path_depth: 1 }
        response = LinksQueryService.query(query)
        expect(response.count).to eq(0)
      end

      it 'should return no records when url do not match' do
        url_params = Domainatrix.parse(url)
        modified_url = url.gsub(url_params.domain, url_params.domain * 2)
        query = { contains: word, url: modified_url, path_depth: 1 }
        response = LinksQueryService.query(query)
        expect(response.count).to eq(0)
      end

      it 'should return no records when path_depth do not match' do
        query = { contains: word * 2, url: url, path_depth: 2 }
        response = LinksQueryService.query(query)
        expect(response.count).to eq(0)
      end
    end
  end
end
