class Brewery < ActiveRecord::Base
  include AverageRating
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, length: {minimum:1}
  validates :year, numericality: {only_integer: true,
                                  greater_than_or_equal_to: 1042}
  validate :founding_year_cannot_be_in_the_future

  def to_s
    self.name
  end

  def founding_year_cannot_be_in_the_future
    if year > Date.today.year
      errors.add(:year, "can't be in the future")
    end
  end
end