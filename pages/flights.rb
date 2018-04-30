require_relative 'base_page'

class Flight < BasePage
  FLIGHTS_BUTTON = { css: '.uitk-icon-flights'}
  FLIGHT_ORIGIN = {id: 'flight-origin-hp-flight'}
  FLIGHT_DESTINATION = {id: 'flight-destination-hp-flight'}
  FLIGHT_DEPARTING_DATE = {id: 'flight-departing-hp-flight'}
  FLIGHT_RETURNING_DATE = {id: 'flight-returning-hp-flight'}
  TRAVELERS = {css: '.gcw-component-initialized'}
  SUBMIT_BUTTON  = {css: '.gcw-submit'}
  SELECT_DEPARTURE = {css: '.title-city-text'}
  CHEAPEST_FLIGHT = {css: 'div:nth-child(2) > button:nth-child(1)'}
  REVIEW_YOUR_TRIP = {css: '.section-header-main'}
  OPT_OUT = {id: 'forcedChoiceNoThanks'}

  def initialize(driver)
    super
    visit
  end

  def select_cheapest_flight
    wait_for { is_displayed? CHEAPEST_FLIGHT}
    click CHEAPEST_FLIGHT
  end

  def date(days_from_now)
    Date.today.next_day(days_from_now).strftime("%m/%d/%Y")
  end

  def select_flights
    wait_for { is_displayed? FLIGHTS_BUTTON}
    click FLIGHTS_BUTTON
  end

  def flying_from(airport)
    type airport, FLIGHT_ORIGIN
  end

  def flying_to(airport)
    type airport, FLIGHT_DESTINATION
  end

  def departing_date(days_from_now = 1)
    click FLIGHT_DEPARTING_DATE
    clear FLIGHT_DEPARTING_DATE
    type date(days_from_now), FLIGHT_DEPARTING_DATE
  end

  def return_date(days_from_now = 10)
    click FLIGHT_RETURNING_DATE
    clear FLIGHT_RETURNING_DATE
    type date(days_from_now), FLIGHT_RETURNING_DATE
  end

  def search
    click SUBMIT_BUTTON
  end

  def opt_out
    wait_for {is_displayed? OPT_OUT}
    click OPT_OUT
    switch_to_new_window
  end

  def flight_success_message(element, text)
    wait_for { is_displayed? element}
    verify_text(element, text)
  end
end
