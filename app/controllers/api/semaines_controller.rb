class Api::SemainesController < ApiController
    before_action :find_semaine, only: [:semaine, :jour]

    #########
    # INDEX #    Renvoi la liste des objets SEMAINE de la semaine courante
    #########
    def index
        paquet = Hash.new
        render json: paquet
    end

    def jour
        if params.has_key?(:date)
            jour = params[:date].to_date.cwday
        else 
            jour = Date.today.cwday
        end
        contenu = contenu_semaine(true, jour)
        render json: contenu
    end

    def semaine
        render json: contenu_semaine
    end



    private

    def find_semaine
        case params[:action]
        when "semaine"
            if params.has_key?(:numero_semaine)
                numero_semaine = params[:numero_semaine]
            else
                numero_semaine = format_numero_semaine(Date.today.year, Date.today.cweek)
            end
        when "jour"
            if params.has_key?(:date)
                date = params[:date].to_date
                numero_semaine = format_numero_semaine(date.year, date.cweek)
            else
                numero_semaine = format_numero_semaine(Date.today.year, Date.today.cweek)
            end
        else 
            numero_semaine = format_numero_semaine(Date.today.year, Date.today.cweek)
        end
        @semaines = Semaine.where(numero_semaine: numero_semaine)
    end


    def contenu_semaine(wl=false, num_jour=nil)
        paquet = Hash.new
        if @semaines.count>0 
            paquet[:numero_semaine] = @semaines.first.numero_semaine
            paquet[:date_lundi] = @semaines.first.date_lundi

            semaines_temp = Hash.new
            @semaines.each do |semaine|
                semaine_temp = Hash.new
                semaine_temp[:id] = semaine.id
                semaine_temp[:note] = semaine.note
                semaine_temp[:utilisateur] = semaine.utilisateur.prenom_nom
                paquet[:semaines] = Hash.new
                jobs_temp = Hash.new
                semaine.jobs.each do |job|
                    job_temp = Hash.new
                    job_temp[:numero_jour] = job.numero_jour
                    if (num_jour==job.numero_jour)
                        job_temp[:id] = job.id
                        job_temp[:am_pm] = job.am_pm
                        job_temp[:note] = job.note

                        wls_temp = Hash.new
                        if wl
                            job.working_lists.each do |working_list|
                                wl_temp = Hash.new
                                wl_temp[:id] = working_list.id
                                wl_temp[:code] = working_list.work.code
                                wl_temp[:nom] = working_list.work.nom
                                wls_temp[working_list.id] = wl_temp
                            end
                        end
                        job_temp[:working_list] = wls_temp

                    end
                    jobs_temp[job.numero_jour] = job_temp
                end
                semaine_temp[:jobs] = jobs_temp
                semaines_temp[semaine.id] = semaine_temp
            end
            paquet[:semaines] = semaines_temp
        end
        return paquet
    end
end