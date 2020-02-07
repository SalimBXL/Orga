class Api::SemainesController < ApiController

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
        render json: Semaine.find(params[:id])
    end

    ###############
    # UTILISATEUR #    Renvoi la semaine courante d'un utilisateur
    ###############
    def utilisateurs
        render json: Semaine.find(params[:id]).utilisateur
    end



    private

    def format_numero_semaine(annee, numero_semaine)
        numero_semaine<10 ? "#{annee}-W0#{numero_semaine}" : "#{annee}-W#{numero_semaine}"
    end

end