class Item < ApplicationRecord
    validates :user_id, presence: true
    # validates :description, presence: true　いらないかも
    validates :image, presence: true
    validates :choice, presence: true

    belongs_to :user
    has_many :calendars, optional: true

    has_many :calendar_items
    has_many :calendars, through: :calendar_items 

    mount_uploader :image, ImageUploader
end
