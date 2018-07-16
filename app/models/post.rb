class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy

  delegate :login, to: :user
end
