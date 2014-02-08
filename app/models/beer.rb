class Beer < ActiveRecord::Base
  include AverageRating
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  validates :name, length: {minimum:1}
  validates :style, length: {minimum: 1}

  def to_s
    "#{self.name} from #{self.brewery.name}"
  end
end
