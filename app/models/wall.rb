class Wall < ApplicationRecord
    include ActionView::Helpers::DateHelper

    validates :construction_date, presence: true
    validates :name, presence: true, uniqueness: true
    validates :wall_material, inclusion: { in: %w(brick concrete wood cement clay),
        message: "isn't valid" }
    validates :size, inclusion: { in: %w(small medium large),
        message: "%(value) isn't valid" }

    def age
        time_ago_in_words(self.construction_date)
    end 

    has_many(
        :requests, dependent: :destroy,
        class_name: 'WallRentalRequest',
        foreign_key: :wall_id,
        primary_key: :id
    )
end 
