class Absence < ApplicationRecord
    belongs_to :type_absence
    belongs_to :utilisateur
    before_validation :check_date_fin
    validates :date, presence: true

    scope :at, -> (d) { where("date <= ? AND date_fin >= ?", d, d) }
    scope :today, -> { self.at(Date.today) }
    scope :at_for_user, -> (d,u) { self.at(d).where(utilisateur: u) }
    scope :today_for_user, -> (u) { self.at_for_user(Date.today, u) }
    scope :en_attente, -> { where(accord: false) }

    def valider
        self.accord = true
    end

    def non_accord
        self.accord = false
    end

    def validee?
        if accord.nil?
            self.accord = false
        end
        self.non_accord
    end

    def check_date_fin
        if date

            # Initialise la date de fin si nulle
            if date_fin.nil? || date_fin.blank? 
                self.date_fin = date
            end
            
            # Corrige la date de fin si anterieure à date de départ
            if date_fin<date
                self.date_fin = date
            end

        end
    end

    def conflict_exists?
        liste1 = Absence.where("date >= ? and date <= ? and id != ? and utilisateur_id = ?", self.date, self.date_fin, self.id, self.utilisateur_id)
        liste2 = Absence.where("date_fin >= ? and date_fin <= ? and id != ? and utilisateur_id = ?", self.date, self.date_fin, self.id, self.utilisateur_id)
        liste3 = Absence.where("date <= ? and date_fin >= ? and id != ? and utilisateur_id = ?", self.date, self.date_fin, self.id, self.utilisateur_id)
        liste = liste1.or(liste2.or(liste3))

        puts "###############"
        puts "ID: #{self.id} USER_ID: #{self.utilisateur_id} - DATE: #{self.date} - DATE_FIN: #{self.date_fin}"
        puts "=========="
        liste1.each do |line|
            puts "+++ (#{line.id})  #{line.date} .. #{line.date_fin} (userID : #{line.utilisateur_id})"
        end
        puts "=========="
        liste2.each do |line|
            puts "+++ (#{line.id})  #{line.date} .. #{line.date_fin} (userID : #{line.utilisateur_id})"
        end
        puts "=========="
        liste3.each do |line|
            puts "+++ (#{line.id})  #{line.date} .. #{line.date_fin} (userID : #{line.utilisateur_id})"
        end
        puts "###############"


        if liste.length > 0
            puts "###############"
            liste.each do |line|
                puts "+++ (#{line.id})  #{line.date} .. #{line.date_fin} (userID : #{line.utilisateur_id})"
            end
            puts "###############"
        end
        
        return liste if liste.length > 0
        false
    end
    
end
