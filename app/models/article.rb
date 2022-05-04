class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates_uniqueness_of :title

  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :user

  has_one_attached :pdf
end
