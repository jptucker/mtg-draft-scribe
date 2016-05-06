class DraftsController < ApplicationController

  def index
    @drafts = Draft.all
  end

  def show
    @draft = Draft.find_by(id: params[:id])
  end

  def new
  end

  def create
    @draft = Draft.new
    @draft.user_id = params[:user_id]
    @draft.set3 = params[:set3]
    @draft.set2 = params[:set2]
    @draft.set1 = params[:set1]
    @draft.color3 = params[:color3]
    @draft.color2 = params[:color2]
    @draft.color1 = params[:color1]

    if @draft.save
      redirect_to drafts_url, notice: "Draft created successfully."
    else
      render 'new'
    end
  end

  def edit
    @draft = Draft.find_by(id: params[:id])
  end

  def update
    @draft = Draft.find_by(id: params[:id])
    @draft.user_id = params[:user_id]
    @draft.set3 = params[:set3]
    @draft.set2 = params[:set2]
    @draft.set1 = params[:set1]
    @draft.color3 = params[:color3]
    @draft.color2 = params[:color2]
    @draft.color1 = params[:color1]

    if @draft.save
      redirect_to drafts_url, notice: "Draft updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @draft = Draft.find_by(id: params[:id])
    @draft.destroy

    redirect_to drafts_url, notice: "Draft deleted."
  end
end
