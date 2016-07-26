class SearchResult < ApplicationRecord
  has_many :links, dependent: :destroy, inverse_of: :search_result
  belongs_to :user

  accepts_nested_attributes_for :links, allow_destroy: true

  def ad_words_count_at_top_position
    self.links.top_ad.count
  end

  def ad_words_count_at_bottom_position
    self.links.bottom_ad.count
  end

  def non_ad_words_count
    self.links.non_ad.count
  end
end
