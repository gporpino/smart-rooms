require 'chronic'

class SmartReservationsController < ApplicationController
  skip_authorization_check

  def index
  end

  def search
    room = params[:room]
    date = params[:date]
    starts = params[:starts]
    duration = params[:duration]

    @rooms_i_belongs = rooms_i_belongs

    if date && starts && duration

      initial = Chronic.parse(date)

      end_date = initial + (duration.split(' ').first).to_i.hours

      @rooms = Room.all.joins(:reservations).where(
        'NOT ((reservations.initial_date BETWEEN :initial_date AND :end_date OR reservations.end_date BETWEEN :initial_date AND :end_date)
        OR (reservations.initial_date <= :initial_date AND end_date >= :end_date))',
        end_date: end_date, initial_date: initial).group('rooms.id')

      @rooms = @rooms.where(name: room) if room
    end

    @rooms = @rooms.map {|x| x}
    
    @rooms.delete_if {|x| 
      @rooms_i_belongs.index(x) == nil 
    }
    # todo
    # @rooms = @rooms.where(name: room) if room

    render 'result', :layout => false
  end

  def facets
    facets = []

    facets << 'room' unless params[:room] if params[:starts] && params[:date] && params[:duration]
    facets << 'starts' unless params[:starts]
    facets << 'date' unless params[:date]
    facets << 'duration' unless params[:duration]


    render json: facets
  end

  def values

    case params.require(:facet)

      when 'room' then
        @result = rooms_i_belongs.map do |r|
          {value: r.name, label: r.name, id: r.id}
        end

      when 'date' then
        @result = ["today","tomorrow","day after tomorrow",
          "Monday","Tuesday","Wednesday","Thursday","Friday",
          "Saturday","Sunday","in 1 days","in 2 days","in 3 days",
          "in 4 days","in 5 days","in 6 days","next Monday",
          "next Tuesday","next Wednesday","next Thursday","next Friday",
          "next Saturday","next Sunday"]

      when 'duration' then
        @result = ["0.5 hours","1 hour","1.5 hours","2 hours",
          "2.5 hours","3 hours","3.5 hours","4 hours","4.5 hours",
          "5 hours","5.5 hours","6 hours","6.5 hours","7 hours",
          "7.5 hours","8 hours","8.5 hours"]

      when 'starts' then
        @result = intervals.map do |r|
          r.to_s(format = :time)
          end
    end
    render json: @result
  end

  private

    def rooms_i_belongs
      rooms_i_belongs = []
      current_user.rooms.each do |room|
        rooms_i_belongs << room
      end
      current_user.associations.each do |room|
        rooms_i_belongs << room
      end
      rooms_i_belongs
    end

    def intervals
      start = DateTime.now.midnight
      finish = start + 24.hours
      [start].tap { |array| array << array.last + 15.minutes while array.last < finish }
    end

end
