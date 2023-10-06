class Movie < ActiveRecord::Base


  # def self.all_ratings
  #   return ['G', 'PG', 'PG-13', 'R']
  # end

  # def self.with_ratings(ratings_list, sort_by)
  #   Movie.where(:rating => ratings_list).order(sort_by)
  # end

  def self.all_ratings
    result = []
    extract = Movie.select(:rating).distinct
    extract.each do |m|
      result << m.rating
    end
    return result
  end

  def self.with_ratings(ratings, sort_by)
    if ratings == nil or ratings.empty? 
      if sort_by
        return Movie.order(sort_by)
      else
        return Movie.all
      end
      
    else
      ratings = ratings.keys.map(&:upcase)
      if sort_by
        return Movie.where(rating: ratings).order(sort_by)
      else
        return Movie.where(rating: ratings)
      end 
      
    end
  end

end
