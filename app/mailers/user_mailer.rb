class UserMailer < ApplicationMailer
    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: 'メールのタイトルがここに入ります')
    end
end
