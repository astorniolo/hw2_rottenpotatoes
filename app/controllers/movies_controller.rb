class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @order = params[:order]
    @ratings_selected = params[:ratings]
    
    if @order  == nil
       @order = session[:order] 
    else
       session[:order] = @order #almaceno nuevo order
    end
          
    if params[:commit] == 'Refresh' #cliente hizo una eleccion de filtros => guardo estos filtros en la sesion
       session[:ratings_selected] = @ratings_selected
    else
       @ratings_selected =  session[:ratings_selected]
    end
           
    @movies = @ratings_selected==nil ? Movie.order(@order) :  Movie.order(@order).find_all_by_rating(@ratings_selected.keys)
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
