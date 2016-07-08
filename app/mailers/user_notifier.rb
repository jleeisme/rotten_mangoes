class UserNotifier < ActionMailer::Base
  default from: "jerkstore@email.com"

  def user_delete(user)
    @user = user
    mail(to: @user.email, subject: 'Account deleted')
  end
end
