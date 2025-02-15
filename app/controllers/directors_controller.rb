class DirectorsController < ApplicationController

  # CRUD
  #--------------------------------------------------
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  #--------------------------------------------------

  def create

    @new_director = Director.new
    @new_director.name = params["query_name"]
    @new_director.dob = params["query_dob"]
    @new_director.bio = params["query_bio"]
    @new_director.image = params["query_image"]

    @new_director.save
    redirect_to("/directors", { :notice => "Course created successfully." })


  end # Of method.

  #--------------------------------------------------

  def update

    the_id = params.fetch("path_id")
    @director = Director.where({ :id => the_id }).at(0)

    @director.name = params["query_name"]
    @director.dob = params["query_dob"]
    @director.bio = params["query_bio"]
    @director.image = params["query_image"]

    @director.save
    redirect_to("/directors/#{the_id}", { :notice => "Director updated successfully."} )

  end # Of method.

  #--------------------------------------------------

  def destroy

    the_id = params["path_id"]
    @director = Director.where({ :id => the_id }).at(0)

    @director.destroy

    redirect_to("/directors", { :notice => "Director deleted successfully."} )

  end # Of method.

  #--------------------------------------------------
  #--------------------------------------------------

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
