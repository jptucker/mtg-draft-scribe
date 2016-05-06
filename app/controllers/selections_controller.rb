class SelectionsController < ApplicationController

  def index
    @selections = Selection.all
  end

  def show
    @selection = Selection.find_by(id: params[:id])
  end

  def new
  end

  def create
    @selection = Selection.new
    @selection.card_id = params[:card_id]
    @selection.draft_id = params[:draft_id]
    @selection.is_sideboard = params[:is_sideboard]

    if @selection.save
      redirect_to selections_url, notice: "Selection created successfully."
    else
      render 'new'
    end
  end

  def edit
    @selection = Selection.find_by(id: params[:id])
  end

  def update
    @selection = Selection.find_by(id: params[:id])
    @selection.card_id = params[:card_id]
    @selection.draft_id = params[:draft_id]
    @selection.is_sideboard = params[:is_sideboard]

    if @selection.save
      redirect_to selections_url, notice: "Selection updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @selection = Selection.find_by(id: params[:id])
    @selection.destroy

    redirect_to selections_url, notice: "Selection deleted."
  end
end
