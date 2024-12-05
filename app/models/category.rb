class Category < ApplicationRecord
    before_save :set_slug

    has_many :categorizations, dependent: :destroy
    has_many :events, through: :categorizations

    validates :name, presence: true, uniqueness: true

    def to_param
        slug
    end

private

    def set_slug
        self.slug = name.parameterize
    end
end
