module Authorization::UserAuthorization
  include Authorization
  extend ActiveSupport::Concern

  included { before_action :user_only }
end
