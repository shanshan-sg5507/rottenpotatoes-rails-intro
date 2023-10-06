class Movie < ActiveRecord::Base

  def self.all_ratings
    distinct_ratings = Movie.distinct.pluck(:rating)
    distinct_ratings.compact
  end

  def self.with_ratings(ratings_list, sort_key)
    ratings_list = ratings_list&.map(&:upcase)

    movies = ratings_list.blank? ? all : where(rating: ratings_list)
    
    movies = movies.order(sort_key) if sort_key.present?
    movies
  end
end
