module AverageRating
  def average_rating
    self.ratings.average(:score)
  end
end