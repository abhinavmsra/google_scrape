class Link < ApplicationRecord
  enum link_type: [:top_ad, :bottom_ad, :non_ad]

  validates_presence_of :link_type, :url

  belongs_to :search_result
end
