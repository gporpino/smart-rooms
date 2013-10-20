class SmartReservationController < ApplicationController
	
	skip_authorization_check 

	autocomplete :category, :name
	
	def autocomplete
	   term = params[:term]
	   quantity, unit = term.split(/\s/)
	   items = unit ? Unit.where('units.name LIKE ?',"#{unit}%") : []
	   json = items.collect do |item| 
	     { "id" => item.id.to_s, 
	       "label" => item.name, 
	       "value" => "#{quantity} #{item.name} "  
	     }
	   end
	   render json: json
	end

	def index
    
  end

end
