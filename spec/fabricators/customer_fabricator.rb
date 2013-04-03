Fabricator(:customer, :class_name => "Customer") do
  id { sequence }
  username { "admin" }
  password { "admin" }
  admin { true }
  email { "whatever@whatever.com" }
  salt { "asdasdastr4325234324sdfds" }
  crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", 
                     "asdasdastr4325234324sdfds") }
end