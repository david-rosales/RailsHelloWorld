class CardsController < ApplicationController
    layout "informationcards"
    def index
        @cards = Card.all
        @newcards = []
        @currentcards = []
        @archivedcards = []
        @cards.each do |card|
            if card.category == "1" #New
                @newcards.push(card)
            elsif card.category == "2" #Current
                @currentcards.push(card)
            else #Archived
                @archivedcards.push(card)
            end
        end
    end
    def new
    end
    def create
        defaults = {:category=>"1"}
        parameters = params.require(:card).permit(:title, :description, :urgency, :details)
        parameters.replace(defaults.merge(parameters))
        @card = Card.new(parameters)
        
        @card.save
        redirect_to action: "index"
    end
    def update
        @card = Card.find(params[:id_param])
        id = @card.id
        defaults = {:category=>@card.category}
        @card.destroy
        parameters = params.require(:card).permit(:title, :description, :urgency, :details)
        parameters.replace(defaults.merge(parameters))
        @card = Card.new (parameters)
        @card.id = id
        @card.save
        redirect_to action: "index"
    end
    def show
        @card = Card.find(params[:id]) 
    end
    def delete
        id = params[:id_param]
        card = Card.find(id)
        card.destroy
        redirect_to action: "index"
    end
    def moveright
        card = Card.find(params[:id_param])
        card.category == "1" ? card.category = "2" : card.category = "3"
        card.save
        redirect_to action: "index"
    end
    def moveleft
        card = Card.find(params[:id_param])
        card.category == "3" ? card.category = "2" : card.category = "1"
        card.save
        redirect_to action: "index"
    end
    def edit
        @card = Card.find(params[:id_param])
    end
end
