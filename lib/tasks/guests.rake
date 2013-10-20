namespace :guests do
  namespace :cleanup do
    desc "Remove guest accounts more than a week old."
    task :oldest => :environment do
      User.where(guest: true).where("created_at < ?", 1.week.ago).destroy_all
    end
    desc "Remove all guest accounts."
    task :all => :environment do
      User.where(guest: true).destroy_all
    end
  end
end
