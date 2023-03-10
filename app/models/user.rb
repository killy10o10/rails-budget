class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :categories, foreign_key: 'author_id'
  has_many :expenses, foreign_key: 'author_id'

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  # validates :email, presence: true:, uniquesess: { case_sensitive: false}
end
