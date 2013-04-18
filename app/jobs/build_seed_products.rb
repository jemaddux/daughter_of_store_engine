class BuildSeedProducts
  @queue = :seed

  def self.perform(store_id)
    1000.times do |i|
      name = Faker::Name.name
      description = Faker::Lorem.paragraph(2)
      Product.create!(store_id: store_id, name: name, description: description, price: "#{(1..500).to_a.sample}.0".to_f, quantity: "#{(1..500).to_a.sample}".to_i, featured: false, active: true)
      print "."
    end
  end

end
