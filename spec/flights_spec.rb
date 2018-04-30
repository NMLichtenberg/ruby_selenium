require_relative '../pages/flights'
require_relative 'spec_helper'

describe 'Flights', component: 'login' do

  before do
    @flight = Flight.new @driver
  end

  def search_for_a_flight(origin = "Salt Lake City, UT (SLC-Salt Lake City Intl", desitination = "Los Angeles, CA (LAX-Los Angeles Intl" )
    @flight.select_flights
    @flight.flying_from origin
    @flight.flying_to desitination
    @flight.departing_date
    @flight.return_date
    @flight.search
  end


  it 'should search for a flight', :search do
    search_for_a_flight
    expect(@flight.flight_success_message(Flight::SELECT_DEPARTURE, 'Select your departure to Los Angeles')).to be true
  end

  it 'should select depature flight', :departure do
    search_for_a_flight
    @flight.select_cheapest_flight
    expect(@flight.flight_success_message(Flight::SELECT_DEPARTURE,'Select your return to Salt Lake City')).to be true
  end

  it 'should select return flight', :return do
    search_for_a_flight
    @flight.select_cheapest_flight
    @flight.select_cheapest_flight
    @flight.opt_out
    expect(@flight.flight_success_message(Flight::REVIEW_YOUR_TRIP, 'Review your trip')).to be true
  end


end
