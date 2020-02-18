class Api::SemainesController < ApiController
    before_action :find_semaine, only: :show

    #########
    # INDEX #    Renvoi la liste des objets SEMAINE de la semaine courante
    #########
    def index
        numero_semaine = format_numero_semaine(Date.today.year, Date.today.cweek)
        render json: Semaine.where(numero_semaine: numero_semaine)
    end

    ########
    # SHOW #    Renvoi les infos d'une semaine
    ########
    def show
        render json: @semaine
    end

    ###############
    # UTILISATEUR #    Renvoi la semaine courante d'un utilisateur
    ###############
    def utilisateurs
        render json: Semaine.find(params[:id]).utilisateur
    end



    private

    def find_semaine
        @semaine = Semaine.find_by_id(params[:identifier])
        @semaine ||= Semaine.find_by_slug(params[:identifier])
    end

end