class CardsController < ApplicationController

  def index
    #@mtgcards = MTG::Card.where(name: params[:q]).all
  end

  def show
    @card = Card.find_by(id: params[:id])
  end

  def search
    if params[:q].present?
      @mtgcards = MTG::Card.where(name: params[:q]).all
    else
      @mtgcards = MTG::Card.where(name: 'avacyn').all
    end
    render 'search'
  end

  def add
    magicCard = MTG::Card.find(params[:card_id])

    card = Card.new
    card.image_url = magicCard.image_url
    card.multiverse_id = magicCard.multiverse_id

    if !magicCard.types.nil?
      card.is_planeswalker = magicCard.types.include? 'Planeswalker'
      card.is_land = magicCard.types.include? 'Land'
      card.is_enchantment = magicCard.types.include? 'Enchantment'
      card.is_artifact = magicCard.types.include? 'Artifact'
      card.is_sorcery = magicCard.types.include? 'Sorcery'
      card.is_instant = magicCard.types.include? 'Instant'
      card.is_creature = magicCard.types.include? 'Creature'
    else
      card.is_planeswalker = card.is_land = card.is_enchantment = card.is_artifact = card.is_sorcery = card.is_instant = card.is_creature = false
    end

    if !magicCard.colors.nil?
      card.is_blue = magicCard.colors.include? 'blue'
      card.is_white = magicCard.colors.include? 'white'
      card.is_red = magicCard.colors.include? 'red'
      card.is_black = magicCard.colors.include? 'black'
      card.is_green = magicCard.colors.include? 'green'
    else
      card.is_blue = card.is_white = card.is_red = card.is_black = card.is_green = false
      card.is_colorless = true
    end

    card.cmc = magicCard.cmc
    card.name = magicCard.name

    if card.save
      selection = Selection.new
      selection.is_sideboard = false
      selection.draft_id = "3"
      selection.card_id = card.id
      if selection.save
        redirect_to cards_url, notice: "Card created successfully."
      end
    else
      render 'index'
    end
  end

  def create
    @card = Card.new
    @card.image_url = params[:image_url]
    @card.multiverse_id = params[:multiverse_id]
    @card.is_planeswalker = params[:is_planeswalker]
    @card.is_land = params[:is_land]
    @card.is_enchantment = params[:is_enchantment]
    @card.is_artifact = params[:is_artifact]
    @card.is_sorcery = params[:is_sorcery]
    @card.is_instant = params[:is_instant]
    @card.is_creature = params[:is_creature]
    @card.is_colorless = params[:is_colorless]
    @card.is_blue = params[:is_blue]
    @card.is_white = params[:is_white]
    @card.is_red = params[:is_red]
    @card.is_black = params[:is_black]
    @card.is_green = params[:is_green]
    @card.cmc = params[:cmc]
    @card.name = params[:name]

    if @card.save
      redirect_to cards_url, notice: "Card created successfully."
    else
      render 'new'
    end
  end

  def edit
    @card = Card.find_by(id: params[:id])
  end

  def update
    @card = Card.find_by(id: params[:id])
    @card.image_url = params[:image_url]
    @card.multiverse_id = params[:multiverse_id]
    @card.is_planeswalker = params[:is_planeswalker]
    @card.is_land = params[:is_land]
    @card.is_enchantment = params[:is_enchantment]
    @card.is_artifact = params[:is_artifact]
    @card.is_sorcery = params[:is_sorcery]
    @card.is_instant = params[:is_instant]
    @card.is_creature = params[:is_creature]
    @card.is_colorless = params[:is_colorless]
    @card.is_blue = params[:is_blue]
    @card.is_white = params[:is_white]
    @card.is_red = params[:is_red]
    @card.is_black = params[:is_black]
    @card.is_green = params[:is_green]
    @card.cmc = params[:cmc]
    @card.name = params[:name]

    if @card.save
      redirect_to cards_url, notice: "Card updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find_by(id: params[:id])
    @card.destroy

    redirect_to cards_url, notice: "Card deleted."
  end
end
