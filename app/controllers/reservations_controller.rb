class ReservationsController < ApplicationController
  load_and_authorize_resource :room
  load_and_authorize_resource :through => :room

  def search
    index
    render :index
  end

  # GET /reservations
  # GET /reservations.json
  def index
    @search = @reservations.search(params[:q])
    @reservations = @search.result.paginate(:page => params[:page])
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation.owner_id = current_user.id
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = @room.reservations.build(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to [@room, @reservation], :flash => { success: 'Reservation was successfully created.' } }
        format.json { render action: 'show', status: :created, location: @reservation }
      else
        format.html { render action: 'new' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to [@reservation.room, @reservation] , :flash => { success: 'Reservation was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to @room,  :flash => { success: 'Reservation was successfully destroyed.' } }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:initial_date, :end_date, :owner_id, :reason)
    end
end
