class CardsetsController < ApplicationController

  def index
    @cardsets = Cardset.all
  end

  def show
    @cardset = Cardset.find_by(id: params[:id])
  end

  def new
  end

  def create
    @cardset = Cardset.new
    @cardset.abbreviation = params[:abbreviation]
    @cardset.name = params[:name]

    if @cardset.save
      redirect_to cardsets_url, notice: "Cardset created successfully."
    else
      render 'new'
    end
  end

  def edit
    @cardset = Cardset.find_by(id: params[:id])
  end

  def update
    @cardset = Cardset.find_by(id: params[:id])
    @cardset.abbreviation = params[:abbreviation]
    @cardset.name = params[:name]

    if @cardset.save
      redirect_to cardsets_url, notice: "Cardset updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @cardset = Cardset.find_by(id: params[:id])
    @cardset.destroy

    redirect_to cardsets_url, notice: "Cardset deleted."
  end
end
