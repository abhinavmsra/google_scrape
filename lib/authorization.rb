# Core authorization module of the application
# Includes various modules that define the authorization rules
#
# The module is supposed to be used with `Devise` Engine, as it uses
# Devise Helpers like `user_signed_in?` and `current_user`.
#
# Every module nested within the `Authorization` module is expected
# to extend `ActiveSupport::Concern` and in the `included` block, add
# `before_action <MODULE_METHOD_NAME>` filters to ensure that the rules for
# actions are invoked prior to controller actions.
#
# @author Abhinav Mishra
module Authorization

  def user_only
    unless current_user
      redirect_to root_path
    end
  end
end
