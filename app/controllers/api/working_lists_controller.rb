class Api::WorkingListsController < ApiController
    before_action :check_if_user_signed_in

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        render json: WorkingList.order(:jour_id, :work_id)
    end


    ########
    # SHOW #
    ########
    def show
        render json: WorkingList.find(params[:id])
    end

    private

    def check_if_user_signed_in
        unless user_signed_in?
            code = :unauthorized
            result = { error: "Not authorized", status: 403 }
            render json: result, status: code 
        end
    end

end