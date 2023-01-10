class User < ApplicationRecord
  has_many :categories, foreign_key: 'author_id'
  has_many :expenses, foreign_key: 'author_id'

  validates :name, presence: true , length: {minimum: 3, maximum: 25 }
end
