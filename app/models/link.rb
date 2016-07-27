class Link < ApplicationRecord
  enum link_type: [:top_ad, :bottom_ad, :non_ad]

  validates_presence_of :link_type, :url

  belongs_to :search_result

  class << self
    def ar_association(&block)
      link_ids = self.all.map do |link|
        link.id if block.call(link)
      end.compact

      self.where(id: link_ids)
    end

    def matches_url(url)
      return self.all unless url.present?
      block = Proc.new do |link|
        self_url_params = Domainatrix.parse(link.url)
        url_params = Domainatrix.parse(url)

        (self_url_params.domain == url_params.domain) && (self_url_params.public_suffix == url_params.public_suffix)
      end
      ar_association &block
    end

    def having_path_depth(n)
      return self.all if (n <= 0)
      block = Proc.new do |link|
        url_params = Domainatrix.parse(link.url)
        slash_count = url_params.path.count('/')
        has_slash_at_last = (url_params.path.last == '/')
        path_depth = has_slash_at_last ? (slash_count - 1) : slash_count

        path_depth == n
      end
      ar_association &block
    end

    def contains(word)
      return self.all unless word.present?
      self.where('url LIKE ?', "%#{word}%")
    end
  end
end
