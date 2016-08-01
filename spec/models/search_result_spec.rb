require 'rails_helper'

RSpec.describe SearchResult, type: :model do
  describe 'validations' do
    subject { build(:search_result) }

    it { is_expected.to validate_presence_of(:key_word) }
    it { is_expected.to validate_presence_of(:links_count) }
    it { is_expected.to validate_presence_of(:html_code) }
    it { is_expected.to validate_presence_of(:search_count) }
    it { is_expected.to validate_presence_of(:worker_ip) }

    it { is_expected.to belong_to(:user) }
  end

  describe 'instance methods' do
    let(:search_result) do
      (0..2).to_a.each {|x| create(:link, link_type: x)}
      create :search_result, links: Link.all
    end

    describe '#ad_words_count_at_top_position' do
      it 'should return the number of ads at top position' do
        expect(search_result.ad_words_count_at_top_position).to eq(1)
      end
    end

    describe '#ad_words_count_at_bottom_position' do
      it 'should return the number of ads at bottom position' do
        expect(search_result.ad_words_count_at_bottom_position).to eq(1)
      end
    end

    describe '#non_ad_words_count' do
      it 'should return the number of non ads' do
        expect(search_result.non_ad_words_count).to eq(1)
      end
    end
  end
end
