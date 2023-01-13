class Api::JoursController < ApiController
    before_action :check_if_user_signed_in, only: [:index, :show]

    #########
    # INDEX #
    #########
    def index
        render json: Jour.order(:date, :service_id, :utilisateur_id, :am_pm)
    end


    ########
    # SHOW #
    ########
    def show
        jour = Jour.find(params[:id])
        groupe = { id: jour.utilisateur.groupe.id, name: jour.utilisateur.groupe.nom }
        utilisateur = { id: jour.utilisateur.id, fullName: jour.utilisateur.prenom_nom }
        service = { id: jour.utilisateur.service.id, name: jour.utilisateur.service.nom, location: jour.utilisateur.service.lieu.nom }
        date = { week: jour.numero_semaine, date: jour.date, day: jour.numero_jour, morning: jour.am_pm }
        result = {
            user: utilisateur,
            groupe: groupe,
            service: service,
            date: date,
            note: jour.note,
            updated: jour.updated_at
        }
        render json: result, status: :ok
    end


    ############
    # CALENDAR #
    ############
    def calendar
        user = Utilisateur.find_by_id(params[:id])
        render json: { nerror: "user not found!", status: :bad_request} if user.nil?

        utilisateur = { id: user.id, fullName: user.prenom_nom }
        today = Date.today
        currentMonth = today.beginning_of_month
        lastMonth = currentMonth - 1.month
        ending = (currentMonth + 10.months).end_of_month
        jours = Jour.where(['date >= ? AND date <= ? AND utilisateur_id = ?', lastMonth, ending, params[:id]]).order(:numero_semaine, :date, :am_pm)
        jobs = []
        jours.each do |jour|
            semaine = jour.numero_semaine
            date = jour.date
            morning = jour.am_pm
            note = jour.note
            service = { id: jour.service.id, name: jour.service.nom, location: jour.service.lieu.nom }
            updated = jour.updated_at
            works = []
            workingList = WorkingList.where(jour_id: jour.id)
            workingList.each do |wkl|
                works.push({ id: wkl.work_id, name: wkl.work.nom })
            end
            job = {
                week: semaine,
                date: date,
                morning: morning,
                note: note,
                service: service,
                works: works,
                updated: updated
            }
            jobs.push(job)
        end
        absences = []
        abs = Absence.where(['date >= ? AND date_fin <= ? AND utilisateur_id = ?', lastMonth, ending, params[:id]])
        abs.each do |ab|
            length = (ab.date_fin + 1.day - ab.date).to_i
            absence = { 
                from: ab.date, 
                to: ab.date_fin,
                length: length,
                type: ab.type_absence.code, 
                validated: ab.accord, 
                halfday: ab.halfday, 
                note: ab.remarque
            }
            absences.push(absence)
        end
        result = {
            user: utilisateur,
            period: "#{lastMonth} - #{ending}",
            jobs: jobs,
            absences: absences
        }
        render json: result, status: :ok
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