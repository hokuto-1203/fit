class Calendar < ApplicationRecord
    belongs_to :user

    mount_uploader :image, ImageUploader

    has_many :items

    has_many :calendar_items
    has_many :items, through: :calendar_items
    accepts_nested_attributes_for :calendar_items, allow_destroy: true
    
end
