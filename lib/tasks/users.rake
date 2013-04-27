namespace :build do
  desc "creating 1000 users"
  task :users => :environment do
    1000.times do |i|
      Customer.create(
          :display_name => "random_user#{i}",
          :email => "demoXX+random#{i}@jumpstartlab.com",
          :password => "password",
          :password_confirmation => "password",
          :admin => false,
          :first_name => Faker::Name.first_name,
          :last_name => Faker::Name.last_name )
    end
  end

  desc "10000 users with 100 background workers" 
  task :users_task => :environment do
    100.times do |i|
      Resque.enqueue(BuildSeedUsers)
    end
  end
end
