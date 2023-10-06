class Movie < ActiveRecord::Base


  # def self.all_ratings
  #   return ['G', 'PG', 'PG-13', 'R']
  # end

  # def self.with_ratings(ratings_list, sort_by)
  #   Movie.where(:rating => ratings_list).order(sort_by)
  # end


  # def self.all_ratings
  #   ratings=[]
  #   Movie.select(:rating).distinct.each do |m|
  #     ratings << m.rating
  #   end
  #   ratings
  # end

  # def self.with_ratings(ratings_list,sort_key)
  #   # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #   #  movies with those ratings
  #   # if ratings_list is nil, retrieve ALL movies
  #   if ratings_list==nil or ratings_list==[]
  #     if sort_key==nil
  #       Movie.all
  #     else
  #       Movie.order(sort_key)
  #     end
  #   else
  #     ratings_list=ratings_list.map(&:upcase)
  #     if sort_key==nil
  #       Movie.where(rating:ratings_list)
  #     else
  #       Movie.where(rating:ratings_list).order(sort_key)
  #     end
  #   end
  # end


  def self.all_ratings
    distinct_ratings = Movie.distinct.pluck(:rating)
    distinct_ratings.compact
  end

  def self.with_ratings(ratings_list, sort_key)
    ratings_list = ratings_list&.map(&:upcase)

    movies = if ratings_list.blank?
               all
             else
               where(rating: ratings_list)
             end

    movies = movies.order(sort_key) if sort_key.present?
    movies
  end
end
