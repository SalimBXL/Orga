class TestController < ApplicationController
    before_action :check_logged_in
    

    #############
    #   INDEX   #
    #############
    def index

        @users1 = User.order(last_connection: :desc)

        date_now = (Time.now - 60.minutes).strftime("%Y-%m-%d")
        time_now = (Time.now - 70.minutes).strftime("%H:%M:%S")
        pp "*************** #{time_now} ***********"
        @users2 = User.where("last_connection::text LIKE ? AND last_connection::time > ?", "#{date_now}%", "#{time_now}").order(last_connection: :desc)
        
    end
end