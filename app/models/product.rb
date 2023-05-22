class Product < ApplicationRecord
    has_one_attached :photo
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :due_date, presence: true
end
