class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true

    has_secure_password

    has_many :items
    has_many :calendars
end
