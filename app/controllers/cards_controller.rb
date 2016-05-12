class CardsController < ApplicationController

  def sideboard
    selection = Selection.find_by(id: params[:selection_id])
    selection.is_sideboard = !selection.is_sideboard
    selection.save
  end

  def search
    if !params[:q].present?
      @hasResults = false
      # @mtgcards = MTG::Card.new
    else
      @mtgcards = MTG::Card.where(name: params[:q]).where(set: 'ktk,soi').all
      if @mtgcards.size == 0
        @hasResults = false
      else
        @hasResults = true
        # remove double-faced
        @mtgcards.each { |card|
          if card.layout=="double-faced" && card.cmc.nil?
            @mtgcards.delete(card)
          end
        }
      end
    end
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
        render 'search', notice: "Card created successfully."
      else
        render 'search', error: "Card creation failed."
      end
    else
      render 'search', error: "Card creation failed."
    end
  end
end
