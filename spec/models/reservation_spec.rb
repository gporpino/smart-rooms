require "spec_helper"
require 'factory_girl'

describe Reservation do
  it "save reservation withou interceted" do
  	reservation = FactoryGirl.build(:reservation)

    reservation.should be_valid

    
  end

  it "save reservation with interceted initialized after" do
  	reservation = FactoryGirl.build(:reservation)

    reservation.should be_valid

    reservation.save

		reservation2 = FactoryGirl.build(:reservation, initial_date: DateTime.now + 10.minutes, end_date: DateTime.now + (1.hour + 10.minutes) )
    
		reservation2.should_not be_valid
  end

  it "save reservation with interceted initialized before" do
  	reservation = FactoryGirl.build(:reservation)

    reservation.should be_valid

    reservation.save

		reservation2 = FactoryGirl.build(:reservation, initial_date: DateTime.now - 1.hour, end_date: DateTime.now + 10.minutes )
    
		reservation2.should_not be_valid
  end

  it "save reservation before" do
  	reservation = FactoryGirl.build(:reservation)

    reservation.should be_valid

    reservation.save

		reservation2 = FactoryGirl.build(:reservation, initial_date: DateTime.now - 1.hour, end_date: DateTime.now - 10.minutes )
    
		reservation2.should be_valid
  end

  it "save reservation after" do
  	reservation = FactoryGirl.build(:reservation)

    reservation.should be_valid

    reservation.save

		reservation2 = FactoryGirl.build(:reservation, initial_date: DateTime.now + 2.hours, end_date: DateTime.now + 3.hours )
    
		reservation2.should be_valid
  end

  it "save reservation just after" do
  	reservation = FactoryGirl.build(:reservation)

    reservation.should be_valid

    reservation.save

		reservation2 = FactoryGirl.build(:reservation, initial_date: DateTime.now + (1.hour + 1.minute), end_date: DateTime.now + 3.hours )
    
		reservation2.should be_valid
  end

it "save reservation just before" do
  	reservation = FactoryGirl.build(:reservation)

    reservation.should be_valid

    reservation.save

		reservation2 = FactoryGirl.build(:reservation, initial_date: DateTime.now - 1.hour, end_date: DateTime.now - 1.minutes )
    
		reservation2.should be_valid
  end

  it "save reservation limite end" do
  	reservation = FactoryGirl.build(:reservation)

    reservation.should be_valid

    reservation.save

		reservation2 = FactoryGirl.build(:reservation, initial_date: DateTime.now + (1.hour), end_date: DateTime.now + 3.hours )
    
		reservation2.should be_valid
  end

it "save reservation limite initial" do

		now = DateTime.now

  	reservation = FactoryGirl.build(:reservation, initial_date: now, end_date: now + 1.hour)

    reservation.should be_valid

    reservation.save

		reservation2 = FactoryGirl.build(:reservation, initial_date: now - 1.hour, end_date: now)
    
		reservation2.should be_valid
  end

end