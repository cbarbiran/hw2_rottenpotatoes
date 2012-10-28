class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort = params[:sort] || session[:sort]
	
	my_movie = Movie.new
	@all_ratings = my_movie.ratings
	
	#@ratings = params[:ratings].keys
	#if @selected_ratings.blank?
	#	@selected_ratings = ['PG','PG-13','R']
	#end
	
	@selected_ratings = @all_ratings
	if params[:ratings].present?
		@selected_ratings = params[:ratings].keys
	end
	
	@movies = Movie.find_all_by_rating(@selected_ratings)
	
	if @sort == 'title'
	  @movies = Movie.find(:all, :order => "title ASC")
	  #@movies = Movie.order("title ASC")
	  #@movies = Movie.find_all_by_rating(@selected_ratings, :order => "title ASC")
	end
	
	if @sort == 'release_date'
	  @movies = Movie.find(:all, :order => "release_date ASC")
	end
	
	
	
	#@selected_ratings = (params[:ratings].present? ? params[:ratings].keys : [])
	
	#@movies = Movie.all
	
	
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
