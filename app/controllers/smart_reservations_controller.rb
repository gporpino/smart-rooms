require 'time'
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

  	facets = []

  	facets << 'starts' unless params[:starts]
  	facets << 'date' unless params[:date]
  	facets << 'duration' unless params[:duration]
  	facets << 'room' unless params[:room]

  	render json: facets
  end


  def values

  	case params.require(:facet)
    	when 'room' then
    		@result = Room.all.map do |r|
  			
  				{value: r.name, label: r.name, id: r.id}

  			end

      when 'date' then
        @result = ["today","tomorrow","day after tomorrow","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday","in 1 days","in 2 days","in 3 days","in 4 days","in 5 days","in 6 days","next Monday","next Tuesday","next Wednesday","next Thursday","next Friday","next Saturday","next Sunday"]

      when 'duration' then
        @result = ["0.5 hours","1 hour","1.5 hours","2 hours","2.5 hours","3 hours","3.5 hours","4 hours","4.5 hours","5 hours","5.5 hours","6 hours","6.5 hours","7 hours","7.5 hours","8 hours","8.5 hours"]

      when 'starts' then

      	time_start = DateTime.now.midnight
      	time_end = (time_start + 1.day).midnight - 15.minutes

      	@result = [time_start].tap { |array| array << array.last + 15.minutes while array.last < time_end }

    		@result = @result.map do |r|
					r.to_s(format = :time)
				end

    end

    render json: @result
  end

end
