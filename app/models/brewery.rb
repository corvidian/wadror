class Brewery < ActiveRecord::Base
  include AverageRating
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, length: {minimum:1}
  validates :year, numericality: {only_integer: true,
                                  greater_than_or_equal_to: 1042},
                   if: :too_old?

  def to_s
    self.name
  end

  def too_old?
    year > Time.now.year
  end
end