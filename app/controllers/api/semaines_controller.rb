class Api::SemainesController < ApiController

    #########
    # INDEX #    Renvoi la liste des objets SEMAINE de la semaine courante
    #########
    def index
        paquet = Hash.new
        numero_semaine = format_numero_semaine(Date.today.year, Date.today.cweek)
        semaines = Semaine.where(numero_semaine: numero_semaine)
        if semaines.count>0 
            paquet[:numero_semaine] = semaines.first.numero_semaine
            paquet[:date_lundi] = semaines.first.date_lundi
        
            semaines_temp = Hash.new
            semaines.each do |semaine|
                semaine_temp = Hash.new
                semaine_temp[:id] = semaine.id
                semaine_temp[:note] = semaine.note
                semaine_temp[:utilisateur] = semaine.utilisateur_id
                
                jobs_temp = Hash.new
                semaine.jobs.each do |job|
                    job_temp = Hash.new
                    job_temp[:id] = job.id
                    job_temp[:numero_jour] = job.numero_jour
                    job_temp[:am_pm] = job.am_pm
                    job_temp[:note] = job.note

                    wls_temp = Hash.new
                    job.working_lists.each do |wl|
                        wl_temp = Hash.new
                        wl_temp[:id] = wl.id
                        wl_temp[:code] = wl.work.code
                        wl_temp[:nom] = wl.work.nom
                        wls_temp[wl.id] = wl_temp
                    end
                    job_temp[:working_list] = wls_temp

                    jobs_temp[job.numero_jour] = job_temp
                end
                semaine_temp[:jobs] = jobs_temp

                semaines_temp[semaine.id] = semaine_temp
            end
            paquet[:semaines] = semaines_temp
        end

        render json: paquet
    end
end