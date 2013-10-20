class SmartReservationsController < ApplicationController
	skip_authorization_check 

	
	
	def index
    
  end

	def search
		room = params[:room]
		whenn = params[:when]

		

  	@result = ['room', 'when']
  	render json: @result
  end	  

  def facets

  	@result = ['room', 'when']
  	render json: @result
  end	

  def values 

  	facet = params[:facet]

  	case facet
    	when 'room' then
        @result = [ 	{ value: 'ITBC', label: 'ITBC' },
          					{ value: 'Cultura', label: 'Cultura' },
          					{ value: 'The Hub', label: 'The Hub' } ]
      
      when 'when' then
        @result = ['tomorrow', 'today']

    end

    render json: @result
  end

end
