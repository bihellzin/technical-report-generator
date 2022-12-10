class TechnicalReport < ApplicationRecord
    validates :name, presence: true
    validates :device, presence: true
    validates :defect, presence: true
    validates :description, presence: true
end
