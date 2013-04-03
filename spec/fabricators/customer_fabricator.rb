Fabricator(:customer, class_name: "Customer") do
  id               { 1 }
  username         { "admin" }
  password         { "admin" }
  first_name       { "John"}
  last_name        { "Doe" }
  admin            { true }
  email            { "test@test.com" }
  salt             { "asdasdastr4325234324sdfds" }
  crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", 
                     "asdasdastr4325234324sdfds") }
end