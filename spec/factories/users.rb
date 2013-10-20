
require 'factory_girl'


FactoryGirl.define do
  factory :owner, :class => User do
    name 'My Name'
    email 'myemail@email.com'
    password '123456'
    password_confirmation '123456'
  end

end