class SmartReservationsController < ApplicationController
	skip_authorization_check



	def index

  end

	def search
		room = params[:room]
		whenn = params[:when]

		
  	
  	# render json: @result
  end	  

  def facets


  	@result = ['room', 'date', 'length']

  	render json: @result
  end


  def values

  	case params.require(:facet)
    	when 'room' then
        @result = [ 	{ value: 'ITBC', label: 'ITBC' },
          					{ value: 'Cultura', label: 'Cultura' },
          					{ value: 'The Hub', label: 'The Hub' } ]

      when 'date' then
        @result = ['tomorrow', 'today']

      when 'length' then
        @result = ['1 hour', '30 minutes']

    end

    render json: @result
  end

end
