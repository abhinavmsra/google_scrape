module Authorization::SessionsAuthorization
  include Authorization
  extend ActiveSupport::Concern

  included { before_action :user_only, only: :destroy }
end
