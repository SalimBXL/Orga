class Api::WorkingListsController < ApiController

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

end