class DraftsController < ApplicationController

  def index
    @drafts = Draft.all
    @sets = Cardset.all
  end

  def show
    @draft = Draft.find_by(id: params[:id])
    session[:draft_id] = @draft.id
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

      entry = { "image" => card.image_url, "selection_id" => sel.id, "is_sideboard" => sel.is_sideboard }
      @fullcardlist.push(entry)
    }

    @chart_power_serieslabels = ["0","1","2","3","4","5","6","7+"]
    powerdata = [0,0,0,0,0,0,0,0]

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
      powerdata[cmc] += 1
      count_colors = 0
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

    @chart_color_data = Array.new
    @chart_color_colors = Array.new
    if num_blue > 0
      @chart_color_data.push(["Blue",num_blue.to_s])
      @chart_color_colors.push("#67C1F5")
    end
    if num_black > 0
      @chart_color_data.push(["Black",num_black.to_s])
      @chart_color_colors.push("#848484")
    end
    if num_red > 0
      @chart_color_data.push(["Red",num_red.to_s])
      @chart_color_colors.push("#F85555")
    end
    if num_green > 0
      @chart_color_data.push(["Green",num_green.to_s])
      @chart_color_colors.push("#26B569")
    end
    if num_white > 0
      @chart_color_data.push(["White",num_white.to_s])
      @chart_color_colors.push("#FCFCC1")
    end
    if num_colorless > 0
      @chart_color_data.push(["Colorless",num_colorless.to_s])
      @chart_color_colors.push("#D0DADC")
    end
    if num_multi > 0
      @chart_color_data.push(["Multi",num_multi.to_s])
      @chart_color_colors.push("#C6B471")
    end

    @chart_power_seriesdata = Array.new
    powerdata.each_with_index do |value, index|
      @chart_power_seriesdata.push([@chart_power_serieslabels[index],powerdata[index].to_s])
    end

    @chart_type_xaxis_categories = ["Creatures","Instants","Sorceries","Artifacts","Enchantments","Lands","Other"]
    @chart_type_seriesdata = Array.new
    @chart_type_seriesdata.push([@chart_type_xaxis_categories[0],num_creatures.to_s])
    @chart_type_seriesdata.push([@chart_type_xaxis_categories[1],num_instants.to_s])
    @chart_type_seriesdata.push([@chart_type_xaxis_categories[2],num_sorceries.to_s])
    @chart_type_seriesdata.push([@chart_type_xaxis_categories[3],num_artifacts.to_s])
    @chart_type_seriesdata.push([@chart_type_xaxis_categories[4],num_enchantments.to_s])
    @chart_type_seriesdata.push([@chart_type_xaxis_categories[5],num_lands.to_s])
    @chart_type_seriesdata.push([@chart_type_xaxis_categories [6],num_other.to_s])

    #Determine draft colors
    @draft.color1 = @draft.color2 = @draft.color3 = nil
    sumcolors = num_white + num_blue + num_black + num_green + num_red
    if sumcolors > 0
      pctwhite = num_white.to_f / sumcolors
      pctblue = num_blue.to_f / sumcolors
      pctblack = num_black.to_f / sumcolors
      pctgreen = num_green.to_f / sumcolors
      pctred = num_red.to_f / sumcolors
      colorshash = {"white" => pctwhite, "blue" => pctblue, "black" => pctblack, "green" => pctgreen, "red" => pctred}
      topcolor = colorshash.max_by{|k,v| v}
      @draft.color1 = topcolor[0] if topcolor[1] >= 0.3
      colorshash.delete(topcolor[0])
      secondcolor = colorshash.max_by{|k,v| v}
      @draft.color2 = secondcolor[0] if secondcolor[1] >= 0.3
      colorshash.delete(secondcolor[0])
      thirdcolor = colorshash.max_by{|k,v| v}
      @draft.color3 = thirdcolor[0] if thirdcolor[1] >= 0.3
    end
    @draft.save

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
      redirect_to "/drafts/" + @draft.id.to_s , notice: "Draft created successfully."
      session[:draft_id] = @draft.id
    else
      render 'index'
    end
  end

  def remove
    selection = Selection.find_by(id: params[:selection_id])
    selection.destroy
    redirect_to "/drafts/" + selection.draft_id.to_s
  end

  def destroy
    @draft = Draft.find_by(id: params[:id])
    @draft.destroy

    redirect_to drafts_url, notice: "Draft deleted."
  end
end
