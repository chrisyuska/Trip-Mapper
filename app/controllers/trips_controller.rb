class TripsController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]

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

  def edit
    @trip = Trip.find_by_marketable_url(params[:marketable_url])
  end
  
  def update
    @trip = Trip.find(params[:id])
    if @trip.update_attributes(params[:trip])
      redirect_to trip_details_path(:marketable_url => @trip.marketable_url), notice: "Trip was successfully updated."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @trip = Trip.find_by_marketable_url(params[:marketable_url])
    @trip.destroy
    redirect_to root_url, :notice => "Successfully deleted trip."
  end

  private

  def authenticate
    if !params[:marketable_url].nil?
      trip = Trip.find_by_marketable_url(params[:marketable_url]) 
    else
      trip = Trip.find_by_marketable_url(params[:trip][:marketable_url]) 
    end
    if params[:authentication_token].nil?
      token = params[:trip][:authentication_token]
    else
      token = params[:authentication_token]
    end
    unless token == trip.authentication_token
      redirect_to trip_details_path(:marketable_url => trip.marketable_url), :notice => "You are unauthorized to do that."
    end
  end
end
