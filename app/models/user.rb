class User < ActiveRecord::Base
  include AverageRating

  validates :username, uniqueness: true,
                       length: { within: 3..15  }

  has_many :ratings
  has_many :beers, through: :ratings
end
