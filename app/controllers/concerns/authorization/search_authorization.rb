module Authorization::SearchAuthorization
  include Authorization
  extend ActiveSupport::Concern

  included { before_action :user_only }
end
