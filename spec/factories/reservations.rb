
require 'factory_girl'

# This will guess the User class
FactoryGirl.define do
	@now = DateTime.now
  factory :reservation do
    reason 'My Reason'
    initial_date DateTime.now
    end_date DateTime.now + 1.hour

    room 
  end

end