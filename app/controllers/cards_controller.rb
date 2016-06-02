class CardsController < ApplicationController

  def sideboard
    selection = Selection.find_by(id: params[:selection_id])
    selection.is_sideboard = !selection.is_sideboard
    selection.save
    redirect_to "/drafts/" + selection.draft_id.to_s
  end

  def search
    if !params[:q].present?
      @hasResults = false
      # @mtgcards = MTG::Card.new
    else
      currentdraft = Draft.find_by(id: session[:draft_id])
      set1 = currentdraft.set1
      set2 = currentdraft.set2
      set3 = currentdraft.set3
      @mtgcards = MTG::Card.where(name: params[:q]).where(set: set1 + "," + set2 + "," + set3).all
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
      card.is_blue = magicCard.colors.include? 'Blue'
      card.is_white = magicCard.colors.include? 'White'
      card.is_red = magicCard.colors.include? 'Red'
      card.is_black = magicCard.colors.include? 'Black'
      card.is_green = magicCard.colors.include? 'Green'
      card.is_colorless = false
    else
      card.is_blue = card.is_white = card.is_red = card.is_black = card.is_green = false
      card.is_colorless = true
    end

    card.cmc = magicCard.cmc
    card.name = magicCard.name

    if card.save
      selection = Selection.new
      selection.is_sideboard = false
      selection.draft_id = session[:draft_id]
      selection.card_id = card.id
      if selection.save
        redirect_to "/drafts/" + selection.draft_id.to_s
      else
        redirect_to "/drafts/" + selection.draft_id.to_s, error: "Card creation failed."
      end
    else
      redirect_to "/drafts/" + selection.draft_id.to_s, error: "Card creation failed."
    end
  end
end
