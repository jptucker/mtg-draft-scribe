class SetsController < ApplicationController

  def index
    @sets = Set.all
  end

  def show
    @set = Set.find_by(id: params[:id])
  end

  def new
  end

  def create
    @set = Set.new
    @set.abbreviation = params[:abbreviation]
    @set.name = params[:name]

    if @set.save
      redirect_to sets_url, notice: "Set created successfully."
    else
      render 'new'
    end
  end

  def edit
    @set = Set.find_by(id: params[:id])
  end

  def update
    @set = Set.find_by(id: params[:id])
    @set.abbreviation = params[:abbreviation]
    @set.name = params[:name]

    if @set.save
      redirect_to sets_url, notice: "Set updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @set = Set.find_by(id: params[:id])
    @set.destroy

    redirect_to sets_url, notice: "Set deleted."
  end
end
