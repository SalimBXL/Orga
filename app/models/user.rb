class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :utilisateur, dependent: :destroy

  #before_validation :set_utilisateur, if: :should_set_utilisateur?

  def set_as_admin
    self.admin = true
  end

  def admin?
    self.admin
  end

  private

  def should_set_utilisateur?
    self.utilisateur.nil?
  end

  def set_utilisateur
    u = Utilisateur.find_by_email(email)
    u.user = self
    u.save
  end
  

end
