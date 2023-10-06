class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end


  def index
    puts '\n\nPRINTING PARAMS'
    puts params
    if not params[:ratings]
      if session[:ratings]
        params[:ratings] = session[:ratings]
      end
    end

    if not params[:sort]
      if session[:sort]
        params[:sort] = session[:sort]
      end
    end

    @all_ratings = Movie.all_ratings
    @ratings_to_show = []
    if params[:ratings]
      params[:ratings].each do |key, array|
        @ratings_to_show << key
      end

      session[:ratings] = params[:ratings]
    end

    #get movies
    if @ratings_to_show == []
      @movies = Movie.with_ratings(@all_ratings)
    else
      @movies = Movie.with_ratings(@ratings_to_show)
    end

    @title_color = ''
    @release_color = ''
    if params[:sort]
      @movies = @movies.order(params[:sort])
      if params[:sort] == 'title'
        @title_color = 'hilite'
      elsif params[:sort] == 'release_date'
        @release_color = 'hilite'
      end

      session[:sort] = params[:sort]
    end

    
    # @movies = Movie.all
  end

    



  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
