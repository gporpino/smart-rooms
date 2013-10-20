class SmartReservationsController < ApplicationController
	skip_authorization_check 

	
	
	def index
    
  end

  def facets

  	@result = ['room', 'when', 'time']
  end	

  def values facet

  	case facet
    	when 'room' then
        @result = [ 	{ value: '1', label: 'ITBC' },
          					{ value: '2', label: 'Cultura' },
          					{ value: '3', label: 'The Hub' } ]
      
      when 'when' then
        @result = ['tomorrow', 'today']

      
      when 'time' then
        @result = ['10:00', 'hugoamorimlyra@gmail.com', 'lucianoncoutinho@hotmail.com']
    end

    @result
  end

end
