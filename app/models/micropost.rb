class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, length: { maximum: 100 }, presence: true
end
