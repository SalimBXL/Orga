class Ajout
        
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :utilisateur, :numero_jour, :date_lundi, :works

    validates_presence_of :utilisateur, :date_lundi, :works

    def initialize()
        @utilisateur = @date_lundi = @numero_jour = nil
        @works = Array.new
    end

    def persisted?
        false
    end

end