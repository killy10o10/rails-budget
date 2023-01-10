class Category < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'

  has_many :expenses_categories, foreign_key: 'category_id'
  has_many :expenses, through: :expenses_categories
end
