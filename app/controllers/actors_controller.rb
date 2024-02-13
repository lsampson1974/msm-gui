class ActorsController < ApplicationController

  # CRUD
  #--------------------------------------------------

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  #--------------------------------------------------

  def create

    @new_actor = Actor.new
    @new_actor.name = params["query_name"]
    @new_actor.dob = params["query_dob"]
    @new_actor.bio = params["query_bio"]
    @new_actor.image = params["query_image"]

    @new_actor.save
    redirect_to("/actors", { :notice => "Actor created successfully." })


  end # Of method.

  #--------------------------------------------------

  def update

    the_id = params.fetch("path_id")
    @actor = Actor.where({ :id => the_id }).at(0)

    @actor.name = params["query_name"]
    @actor.dob = params["query_dob"]
    @actor.bio = params["query_bio"]
    @actor.image = params["query_image"]

    @actor.save
    redirect_to("/actors/#{the_id}", { :notice => "Actor updated successfully."} )

  end # Of method.

  #--------------------------------------------------

  def destroy

    the_id = params["path_id"]
    @actor = Actor.where({ :id => the_id }).at(0)

    @actor.destroy

    redirect_to("/actors", { :notice => "Actor deleted successfully."} )

  end # Of method.


  #--------------------------------------------------
  #--------------------------------------------------



  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
