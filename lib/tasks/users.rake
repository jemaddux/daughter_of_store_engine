namespace :create do
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
      puts "creating user #{i}"
    end
  end
end
