class DraftsController < ApplicationController

  def index
    @drafts = Draft.all
    @sets = Cardset.all
  end

  def show
    @draft = Draft.find_by(id: params[:id])
    selections = Selection.where(:draft_id => @draft.id)
    @fullcardlist = Array.new
    @cards = Array.new
    selections.each { |sel|
      card = Card.find_by(:id => sel.card_id)

      #Load played cards into the @cards array
      if !sel.is_sideboard
        @cards.push(card)
      end

      #Load all cards into the @fullcardlist array
      entry = Hash.new

      entry = { "image" => card.image_url, "selection_id" => sel.id }
      @fullcardlist.push(entry)
    }

    @chart_power_seriesdata = [0,0,0,0,0,0,0,0]

    num_blue = 0
    num_black = 0
    num_red = 0
    num_green = 0
    num_white = 0
    num_colorless = 0
    num_multi = 0
    count_colors = 0

    num_creatures = 0
    num_instants = 0
    num_sorceries = 0
    num_artifacts = 0
    num_enchantments = 0
    num_lands = 0
    num_other = 0

    @cards.each { |card|
      cmc = [card.cmc.to_i,7].min
      @chart_power_seriesdata[cmc] += 1
      count_colors +=1 if card.is_blue
      count_colors +=1 if card.is_black
      count_colors +=1 if card.is_red
      count_colors +=1 if card.is_green
      count_colors +=1 if card.is_white


      if card.is_colorless
        num_colorless +=1
      else
        if count_colors > 1
          num_multi += 1
        else
          if card.is_blue
            num_blue += 1
          else
            if card.is_black
              num_black +=1
            else
              if card.is_red
                num_red +=1
              else
                if card.is_green
                  num_green += 1
                else
                  if card.is_white
                    num_white +=1
                  end
                end
              end
            end
          end
        end
      end

      if card.is_creature
        num_creatures += 1
      end
      if card.is_instant
        num_instants += 1
      end
      if card.is_sorcery
        num_sorceries += 1
      end
      if card.is_artifact
        num_artifacts += 1
      end
      if card.is_enchantment
        num_enchantments += 1
      end
      if card.is_land
        num_lands += 1
      end
      if !card.is_creature && !card.is_instant && !card.is_sorcery && !card.is_artifact && !card.is_enchantment && !card.is_land
        num_other += 1
      end
    }

    @chart_power_xaxis_categories = ["0","1","2","3","4","5","6","7+"]

    @chart_color_data = [['Blue',num_blue], ['Black',num_black],['Red',num_red],['Green',num_green],['White',num_white],['Colorless',num_colorless],['Multi',num_multi]]
    @chart_color_colors = ['#67C1F5','#848484','#F85555','#26B569','#FCFCC1','#D0DADC','#C6B471']

    @chart_type_xaxis_categories = ["Creatures","Instants","Sorceries","Artifacts","Enchantments","Lands","Other"]
    @chart_type_seriesdata = [num_creatures,num_instants,num_sorceries,num_artifacts,num_enchantments,num_lands,num_other]

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
      redirect_to :action => :show , notice: "Draft created successfully."
    else
      render 'index'
    end
  end

  def destroy
    @draft = Draft.find_by(id: params[:id])
    @draft.destroy

    redirect_to drafts_url, notice: "Draft deleted."
  end
end
