class SearchResult < ApplicationRecord
  has_many :links, dependent: :destroy, inverse_of: :search_result
  belongs_to :user

  accepts_nested_attributes_for :links, allow_destroy: true
end
