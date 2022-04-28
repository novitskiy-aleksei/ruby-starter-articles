class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 20 }
  validates_uniqueness_of :title

  validates :body, presence: true, length: { minimum: 10 }
end
