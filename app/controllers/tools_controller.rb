class ToolsController < ApplicationController

    # ACCUEIL
    def index
        # Log action
        log(request.path)
    end


    ##############
    # CHECK DAYS #
    ##############
    def check_days
        @problemes = Array.new

        # on fait la liste des days
        jours = Jour.all

        # pour chaque day, on vérifie s'il y a au moins une working_list
        if jours
            jours.each do |jour|
                working_lists = jour.working_lists
                @problemes << jour if working_lists.count <1
            end
        end
    end


    ################
    # CHECK ADMINS #
    ################
    def check_admins
        @managers = Array.new
        @super_admins = Array.new
        @problems = Array.new
        Utilisateur.all.each do |utilisateur|
            @managers << utilisateur if utilisateur.admin and !utilisateur.profil.admin
            @super_admins << utilisateur if utilisateur.admin and utilisateur.profil.admin
            @problems << utilisateur if !utilisateur.admin and utilisateur.profil.admin
        end
    end


    ###############
    # CHECK USERS #
    ###############
    def check_users
        @problemes = Hash.new

        # on fait la liste des utilisateurs et des profils de login
        @utilisateurs = Utilisateur.all
        @profiles = User.all

        # pour chaque utilisateur, on vérifie s'il y a au moins un profil
        if @utilisateurs
            @utilisateurs.each do |utilisateur|
                @problemes[utilisateur.email] ||= Hash.new
                @problemes[utilisateur.email]["utilisateur"] = utilisateur
            end
        end

        # pour chaque profil, on vérifie s'il y a au moins un utilisateur
        if @profiles
            @profiles.each do |profile|
                @problemes[profile.email] ||= Hash.new
                @problemes[profile.email]["profile"] = profile
            end
        end
    end

    private 



end