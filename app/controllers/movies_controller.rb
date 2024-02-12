class MoviesController < ApplicationController

  # CRUD
  #--------------------------------------------------

  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  #--------------------------------------------------

  def create

    @new_movie = Movie.new
    @new_movie.title = params["query_title"]
    @new_movie.year = params["query_year"]
    @new_movie.duration = params["query_duration"]
    @new_movie.description = params["query_description"]
    @new_movie.director_id = params["query_director_id"]
    @new_movie.image = params["query_image"]


    @new_movie.save
    redirect_to("/movies", { :notice => "Movie created successfully." })


  end # Of method.

  #--------------------------------------------------

  def update

    the_id = params.fetch("path_id")
    @movie = Movie.where({ :id => the_id }).at(0)

    @movie.title = params["query_title"]
    @movie.year = params["query_year"]
    @movie.duration = params["query_duration"]
    @movie.description = params["query_description"]
    @movie.director_id = params["query_director_id"]
    @movie.image = params["query_image"]

    @movie.save
    redirect_to("/movie/#{the_id}", { :notice => "Movie updated successfully."} )

  end # Of method.

  #--------------------------------------------------

  def destroy

    the_id = params["path_id"]
    @movie = Movie.where({ :id => the_id }).at(0)

    @movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )

  end # Of method.

  #--------------------------------------------------
  #--------------------------------------------------


  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end
end
