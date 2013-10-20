class RoomsController < ApplicationController
  include ActionView::Helpers::DateHelper
  load_and_authorize_resource

  # GET /rooms
  # GET /rooms.json
  def index
    @search = @rooms.search(params[:q])
    @rooms = @search.result.paginate(:page => params[:page])
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @search = @room.reservations.search(params[:q])
    @reservations = @search.result.where("initial_date > ?", Date.today).paginate(:page => params[:page], :per_page => 4)
  end

  # GET /rooms/new
  def new
    @room.owner_id = current_user.id
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, :flash => { success: 'Room was successfully created.' } }
        format.json { render action: 'show', status: :created, location: @room }
      else
        format.html { render action: 'new' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params_update)
        format.html { redirect_to @room, :flash => { success: 'Room was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url :flash => { success: 'Room was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  def reservation
    reservations = Room.find(params.require(:room_id)).reservations.map do |r|
      {
        startDate: r.initial_date.strftime('%Y/%m/%d %H:%M:%S'),
        endDate: r.end_date.strftime('%Y/%m/%d %H:%M:%S'),
        title: "#{r.owner.name} ends #{r.end_date.strftime('%H:%M')}",
        description: "#{r.owner.name} for #{r.reason} lets take #{distance_of_time_in_words(r.initial_date, r.end_date)}",
        priority: 3,
        frecuency: 1
      }
    end
    render :json => reservations
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:owner_id, :name, {:user_ids => [] })
    end

    def room_params_update
      params.require(:room).permit(:name, {:user_ids => [] })
    end
end
