class SmartReservationsController < ApplicationController

  def index

  end

  def search
    room = params[:room]
    whenn = params[:when]
    @rooms = Room.all
    render 'index'
  end

  def facets
    render json: ['Starts in', 'Date', 'Length', 'Room is']
  end

  def values

    case params.require(:facet)

      when 'Room is' then
        @result = rooms.map do |r|
          {value: r.name, label: r.name, id: r.id}
        end

      when 'Date' then
        @result = ["today","tomorrow","day after tomorrow",
          "Monday","Tuesday","Wednesday","Thursday","Friday",
          "Saturday","Sunday","in 1 days","in 2 days","in 3 days",
          "in 4 days","in 5 days","in 6 days","next Monday",
          "next Tuesday","next Wednesday","next Thursday","next Friday",
          "next Saturday","next Sunday"]

      when 'Length' then
        @result = ["0.5 hours","1 hour","1.5 hours","2 hours",
          "2.5 hours","3 hours","3.5 hours","4 hours","4.5 hours",
          "5 hours","5.5 hours","6 hours","6.5 hours","7 hours",
          "7.5 hours","8 hours","8.5 hours"]

      when 'Starts in' then
        @result = intervals.map do |r|
          r.to_s(format = :time)
        end

    end
    render json: @result
  end

  private

    def rooms
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
