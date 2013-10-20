
require 'factory_girl'

FactoryGirl.define do
  sequence(:reason) {|n| "My Reason #{n}" }
  sequence(:name) {|n| "My Name #{n}" }

end
