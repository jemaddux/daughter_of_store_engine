namespace :build do
  desc "creating 1000 products per store"
  task :products => :environment do
    Store.all[0..10].each do |store|
      9982.times do |i|
        Product.create!(store_id: store.id, name: Faker::Name.name, description: Faker::Lorem.paragraph(2), price: "#{(1..500).to_a.sample}.0".to_f, quantity: "#{(1..500).to_a.sample}".to_i, featured: false, active: true)
        print "."
      end
    end
  end
end
