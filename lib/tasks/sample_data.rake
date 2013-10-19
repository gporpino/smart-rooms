namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    49.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@smartrooms.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
