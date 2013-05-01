class BuildSeedProducts
  @queue = :seed

  def self.perform(store_id)
    1000.times do |i|
      cats = %w(sunglasses goggles skis snowboards boots helmets gloves backpacks cameras luggage clothing)
      Product.create!(
        store_id: store_id,
        categories_list:cats.sample,
        name: Faker::Name.name, 
        description: Faker::Lorem.paragraph(4),
        price: "#{(1..500).to_a.sample}.0".to_f,
        quantity: "#{(1..500).to_a.sample}".to_i,
        featured: false, 
        active: true)
    end
  end
end
