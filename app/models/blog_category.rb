class BlogCategory < ApplicationRecord
    has_many :blog_messages, dependent: :destroy
    validates_associated :blog_messages
    validates :nom, presence: true
    validates :nom, uniqueness: true
end
