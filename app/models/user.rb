class User < ActiveRecord::Base
  include AverageRating

  has_secure_password

  validates :username, uniqueness: true,
                       length: { within: 3..15  }
  validates :password, length: { minimum: 4 },
                       format: { with: /([A-Z].*\d|\d.*[A-Z])/,
                                 message: 'must contain at least one capital letter and a number' }

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    Beer.select(:style).group(:style).joins(:ratings).where(ratings: {user: self})
    .map { |i| i.style }
    .map { |style|
      {style => ratings.joins(:beer).where(beers: {style: style}).average(:score)}
    }.reduce({}, :update).max
  end
end
