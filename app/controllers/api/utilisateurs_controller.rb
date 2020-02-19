class Api::UtilisateursController < ApiController

    #########
    # INDEX #    Renvoi la liste des utilisateurs
    #########
    def index
        groupes = Hash.new
        utilisateurs = Hash.new
        Groupe.order(:nom).each do |groupe|
            unless groupes.has_key?(groupe.id)
                groupes[groupe.id] = groupe.nom
            end
        end
        Utilisateur.order(:groupe_id, :nom, :prenom).select(:id, :prenom, :nom, :groupe_id).each do |utilisateur|
            temp = Hash.new
            temp[:id] = utilisateur.id
            temp[:nom] = utilisateur.nom
            temp[:prenom] = utilisateur.prenom
            temp[:groupe] = groupes[utilisateur.groupe_id]
            utilisateurs[utilisateur.id] = temp
        end
        render json: utilisateurs
    end

end