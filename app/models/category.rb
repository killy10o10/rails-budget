class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }


  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :expenses_categories, foreign_key: 'category_id'
  has_many :expenses, through: :expenses_categories
end
