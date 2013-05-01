class BuildSeedUsers
  @queue = :seed

  def self.perform
    100.times do |i|
      t = SecureRandom.hex(3)
    Customer.create(
      :display_name => "random_user#{t}",
      :email => "demoxx+random#{t}@jumpstartlab.com",
      :password => "password",
      :password_confirmation => "password",
      :admin => false,
      :first_name => Faker::Name.first_name,
      :last_name => Faker::Name.last_name )
    end
  end

end
