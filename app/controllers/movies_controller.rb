class MoviesController < ApplicationController

  # def index
  #   @movies = Movie.all.page(params[:page]).per(10)
  #   # @movies = Movie.search(params[:search])
  # end
  def index
    @movies = Movie.all
    if params[:query]
      @movies = Movie.search(params[:query])    
    else
      @movies = Movie.all
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private

  def movie_params
    params["movie"]["release_date"] = params["movie"]["release_date"].to_date
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description)
  end


end
