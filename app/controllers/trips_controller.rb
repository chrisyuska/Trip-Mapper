class TripsController < ApplicationController

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = Trip.find_by_marketable_url(params[:marketable_url])
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = Trip.new
    @trip.steps.build
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(params[:trip])

    if @trip.save
      Notifier.confirmation(@trip).deliver
      redirect_to trip_details_path(:marketable_url => @trip.marketable_url), notice: "Trip was successfully created."
    else
      render action: "new"
    end
  end

#  def destroy
#    @trip = Trip.find(params[:id])
#    @trip.destroy
#    redirect_to root_url, :notice => "Successfully deleted trip."
#  end
end
