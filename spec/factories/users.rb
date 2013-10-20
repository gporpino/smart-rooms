
require 'factory_girl'


FactoryGirl.define do
	

  factory :owner, :class => User do
    name 
    email { "#{name}@example.com".downcase }
    password '123456'
    password_confirmation '123456'
  end

end