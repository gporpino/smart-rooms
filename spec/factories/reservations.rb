
require 'factory_girl'

# This will guess the User class
FactoryGirl.define do
	


  factory :reservation do
    
    initial_date DateTime.now
    end_date DateTime.now + 1.hour

		reason :reason
    room 
  end

end