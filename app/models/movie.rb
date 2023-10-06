class Movie < ActiveRecord::Base


  # def self.all_ratings
  #   return ['G', 'PG', 'PG-13', 'R']
  # end

  # def self.with_ratings(ratings_list, sort_by)
  #   Movie.where(:rating => ratings_list).order(sort_by)
  # end

  def self.all_ratings
    self.uniq.pluck(:rating)
  end

  def self.with_ratings(ratings)
    self.where(rating: ratings)
  end
  
end
