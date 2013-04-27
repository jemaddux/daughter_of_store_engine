namespace :build do  
  desc "creating 1000 products per store"
  task :products => :environment do
    Store.all[0..10].each do |store|
      10000.times do |i|
        Product.create!(store_id: store.id, name: Faker::Name.name, description: Faker::Lorem.paragraph(2), price: "#{(1..500).to_a.sample}.0".to_f, quantity: "#{(1..500).to_a.sample}".to_i, featured: false, active: true)
        print "."
      end
    end
  end

  desc "1000 background task products per store" 
  task :products_task => :environment do
    a = Time.now
    Store.all[0..10].each do |store|
      10.times do |i|
        Resque.enqueue(BuildSeedProducts,store.id)
        print "."
      end
    end
    print "#{Time.now - a}"
  end

end

