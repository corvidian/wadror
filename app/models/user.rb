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
    a = Beer.select(:style).group(:style).joins(:ratings).where(ratings: {user: self})
    .map { |i| i.style }
    .map { |style|
      {style => ratings.joins(:beer).where(beers: {style: style}).average(:score)}
    }.reduce({}, :update).max_by{|k,v| v}

    { name: a.first, score:a.second } if a
  end

  def favorite_brewery
    a = Brewery.select('breweries.*').joins(:beers)
               .joins(:ratings).where(ratings: {user: self})
               .group('breweries.id').average('ratings.score')
               .max_by{|k,v| v}

    Brewery.find(a.first) if a
  end
end
