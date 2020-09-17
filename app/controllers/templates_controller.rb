class TemplatesController < ApplicationController
    before_action :check_logged_in
    before_action :find_template, only: [:edit, :update, :destroy, :valider, :dupliquer]
    before_action :find_utilisateurs, only: [:new, :create, :edit, :modification]
    before_action :find_groupes, only: [:new, :create, :edit, :modification]
    before_action :find_works, only: [:index, :new, :create, :edit, :modification]
    before_action :find_classes, only: [:new, :create, :edit, :modification]
    before_action :find_services, only: [:new, :create, :edit, :modification, :index]
    before_action :build_list, only: [:new, :create, :edit, :modification]

    #############
    #   INDEX   #
    #############
    def index
        @templates = Template.order(:nom)
    end

    def show
    end



    ##########
    #   NEW  #
    ##########
    def new
        @template = Template.new
    end
    

    ##############
    #   CREATE   #
    ##############
    def create
        @template = Template.create(template_params)
        if @template.save
            flash[:notice] = "Template créé avec succès"
        else
            render :new
        end
        redirect_to templates_path
    end


    #############
    #   EDIT    #
    #############
    def edit
    end


    #############
    #   UPDATE  #
    #############
    def update
        if @template.update(template_params)
            flash[:notice] = "Template modifié avec succès"
            redirect_to templates_path
        else 
            render :edit
        end
    end
    

    ##############
    #   DESTROY  #
    ##############
    def destroy
        @template.destroy
    end


    private

    def template_params
        params.require(:template).permit(:nom, 
            :description, :service_id, 
            :work1_1, :work1_2, :work1_3, :work1_4, :work1_5, 
            :work2_1, :work2_2, :work2_3, :work2_4, :work2_5, 
            :work3_1, :work3_2, :work3_3, :work3_4, :work3_5, 
            :work4_1, :work4_2, :work4_3, :work4_4, :work4_5, 
            :work5_1, :work5_2, :work5_3, :work5_4, :work5_5)
    end

    def find_template
        @template = Template.find_by_id(params[:id])
    end

    def build_list
        @liste = [
            [:work1_1, :work1_2, :work1_3, :work1_4, :work1_5],
            [:work2_1, :work2_2, :work2_3, :work2_4, :work2_5],
            [:work3_1, :work3_2, :work3_3, :work3_4, :work3_5],
            [:work4_1, :work4_2, :work4_3, :work4_4, :work4_5],
            [:work5_1, :work5_2, :work5_3, :work5_4, :work5_5]
        ]
    end

end