require 'rails_helper'

RSpec.describe Link, type: :model do

  describe 'validations' do
    subject { build(:link) }

    it { is_expected.to validate_presence_of(:link_type) }
    it { is_expected.to validate_presence_of(:url) }

    it { is_expected.to belong_to(:search_result) }
  end

  describe '.matches_url' do
    let(:url) { Faker::Internet.url }

    context 'for records with a specific url' do
      let(:count) { Faker::Number.between(1, 5) }

      before(:each) { count.times { create(:link, url: url) } }

      it 'should return all those records' do
        expect(Link.matches_url(url).count).to eq(count)
      end
    end

    context 'when domain do not match' do
      it 'should return no records' do
        url_params = Domainatrix.parse(url)
        modified_url = url.gsub(url_params.domain, url_params.domain*2)
        create(:link, url: url)
        expect(Link.matches_url(modified_url).count).to eq(0)
      end
    end

    context 'when public_suffix do not match' do
      it 'should return no records' do
        url_params = Domainatrix.parse(url)
        modified_url = url.gsub(url_params.public_suffix, url_params.public_suffix*2)
        create(:link, url: url)
        expect(Link.matches_url(modified_url).count).to eq(0)
      end
    end
  end

  describe '.having_path_depth' do
    context 'when urls have specified path depths' do
      it 'should return all those records' do
        url = Faker::Internet.url('example.com', '/foobar.html')
        create(:link, url: url)

        expect(Link.having_path_depth(1).count).to eq(1)
      end
    end

    context 'when urls dont have specified path depths' do
      it 'should return no records' do
        url = Faker::Internet.url('example.com', '/foo/foobar.html')
        create(:link, url: url)

        expect(Link.having_path_depth(1).count).to eq(0)
      end
    end
  end

  describe '.contains' do
    let(:word) { Faker::Lorem.word }

    before(:each) do
      url = Faker::Internet.url("#{word}.com", '/foobar.html')
      create(:link, url: url)
    end

    context 'when url contains a specific word' do
      it 'should return all those records' do
        expect(Link.contains(word).count).to eq(1)
      end
    end

    context 'when url contains a specific word' do
      it 'should return no records' do
        expect(Link.contains(word * 2).count).to eq(0)
      end
    end
  end
end
