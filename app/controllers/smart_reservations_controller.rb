class SmartReservationsController < ApplicationController
	skip_authorization_check



	def index

  end

  def facets

  	@result = ['room', 'date', 'length']
  	render json: @result
  end

  def values

  	case params.require(:facet)
    	when 'room' then
        @result = [ 	{ value: '1', label: 'ITBC' },
          					{ value: '2', label: 'Cultura' },
          					{ value: '3', label: 'The Hub' } ]

      when 'date' then
        @result = ['tomorrow', 'today']


      when 'length' then
        @result = ['10:00', 'hugoamorimlyra@gmail.com', 'lucianoncoutinho@hotmail.com']
    end

    render json: @result
  end

end
