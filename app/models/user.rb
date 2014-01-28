class User < ActiveRecord::Base
  include AverageRating

  has_secure_password

  validates :username, uniqueness: true,
                       length: { within: 3..15  }
  validates :password, length: { minimum: 4 },
                       format: { with: /[A-Z]/, message: 'must contain at least one capital letter' }

  has_many :ratings
  has_many :beers, through: :ratings
end
