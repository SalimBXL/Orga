class ExportController < ApplicationController

    def index 
        
    end

    def logbook_articles_json
        @json = Utilisateur.all.as_json
    end

    def show
        respond_to  do |format|
            format.html
            format.pdf do
                pdf = render_to_string :pdf => 'test',
                layout: 'pdf.html.erb',
                template: 'show.pdf.slim',
                header: { :right => '[page] of [topage]' },
                margin: { top: 0, bottom: 0, left: 0, right: 0 },
                outline: { outline: true, outline_depth: 2 }
            end
        end
    end

    
    #################
    #   ICAL ICS    #
    #################
    def ical_export_ics
        j = Jour.find(params[:jour])
        @jours = Jour.where(date: j.date, utilisateur: j.utilisateur)
        if @jours.size > 0
            @utilisateur_email = @jours.first.utilisateur.email
            @administrateur_prenom_nom = current_user.utilisateur.prenom_nom
            @administrateur_email = current_user.utilisateur.email
            @service_nom = @jours.first.service.nom
            @lieu_nom = @jours.first.service.lieu.nom
        end

        respond_to do |format|
            format.html
            format.text do
                render text: "file_name"
            end
        end

    end

    ########################
    #   BLOG MESSAGE PDF   #
    ########################
    def blog_message_export_pdf

        @blog_messages = Array.new

        if params[:blog_message]
            blog_message = BlogMessage.find(params[:blog_message])
            article = Hash.new
                article[:id] = blog_message.id
                article[:blog_message] = blog_message
                article[:service] = blog_message.service_id ? Service.find(blog_message.service_id): nil
                article[:utilisateur] = blog_message.utilisateur_id ? Utilisateur.find(blog_message.utilisateur_id) : nil
                article[:category] = blog_message.blog_category_id ? BlogCategory.find(blog_message.blog_category_id) : nil
                article[:groupe] = blog_message.groupe ? Groupe.find(blog_message.groupe) : nil
                article[:classe] = blog_message.classe ? Classe.find(blog_message.classe) : nil
                @blog_messages << article
        elsif params[:date]
            liste = BlogMessage.where("date >= ? and date <= ?", params[:date].to_datetime.strftime("%Y-%m-%d"), params[:date].to_datetime.end_of_month.strftime("%Y-%m-%d")).where(logbook: true).order(:date)
            liste.each do |blog_message|
                article = Hash.new
                article[:id] = blog_message.id
                article[:blog_message] = blog_message
                article[:service] = blog_message.service_id ? Service.find(blog_message.service_id): nil
                article[:utilisateur] = blog_message.utilisateur_id ? Utilisateur.find(blog_message.utilisateur_id) : nil
                article[:category] = blog_message.blog_category_id ? BlogCategory.find(blog_message.blog_category_id) : nil
                article[:groupe] = blog_message.groupe ? Groupe.find(blog_message.groupe) : nil
                article[:classe] = blog_message.classe ? Classe.find(blog_message.classe) : nil
                @blog_messages << article
            end
        end

        respond_to do |format|
            format.html
            format.pdf do
                render pdf: "file_name"
            end
        end
    end

end