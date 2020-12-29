class UserMailer < ApplicationMailer
    default from: 'anthony.joly@erasme.ulb.ac.be'

    def welcome_email
        @user   = params[:user]
        @url    = 'http://example.com/login'
        mail(to: @user.email, subject: 'Welcome to My Awesome App')
    end
end
