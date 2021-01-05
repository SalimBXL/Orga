class ExportController < ApplicationController
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

        #respond_to do |format|
        #    #some other formats like: format.html { render :show }
        #    format.pdf do
        #        pdf = Prawn::Document.new
        #        pdf.text "Hellow World!!!"
        #        send_data pdf.render,
        #            filename: "export.pdf",
        #            type: 'application/pdf',
        #            disposition: 'inline'
        #    end
        #end

    end


    ########################
    #   BLOG MESSAGE PDF   #
    ########################
    def blog_message_export_pdf
        blog_message = BlogMessage.find(params[:blog_message])
        @service = Service.find(blog_message.service_id) if blog_message.service_id
        @utilisateur = Utilisateur.find(blog_message.utilisateur_id) if blog_message.utilisateur_id
        @category = BlogCategory.find(blog_message.blog_category_id) if blog_message.blog_category_id
        @groupe = Groupe.find(blog_message.groupe) if blog_message.groupe
        @classe = Classe.find(blog_message.classe) if blog_message.classe
        @blog_message = blog_message

        respond_to do |format|
            format.html
            format.pdf do
                render pdf: "file_name"
            end
        end


        # respond_to  do |format|
        #     format.html
        #     format.pdf do
        #         pdf = render_to_string :pdf => 'test',
        #         #layout: 'pdf.html.erb',
        #         template: 'exports/blog_message_export_pdf.html.erb',
        #         header: { :right => '[page] of [topage]' },
        #         margin: { top: 0, bottom: 0, left: 0, right: 0 },
        #         outline: { outline: true, outline_depth: 2 }
        #     end
        # end
        
        # respond_to do |format|
        #     #some other formats like: format.html { render :show }
        #     format.pdf do
        #         pdf = Prawn::Document.new
        #         pdf.text service.nom
        #         pdf.text utilisateur.prenom_nom
        #         pdf.text blog_category.nom
        #         pdf.text groupe.nom
        #         pdf.text classe.nom
        #         pdf.text blog_message.title
        #         pdf.text blog_message.keywords
        #         pdf.text blog_message.description
        #         pdf.text blog_message.created_at.to_s
                
        #         send_data pdf.render,
        #             filename: "export.pdf",
        #             type: 'application/pdf',
        #             disposition: 'inline'
        #     end
        # end
    end

end