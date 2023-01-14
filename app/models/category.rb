class Category < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }


  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :expense_categories, foreign_key: 'category_id', dependent: :destroy
  has_many :expenses, through: :expense_categories, dependent: :destroy
end
