ENV["REDISTOGO_URL"] ||= "redis://redistogo:a32b86dc8c1e5cdad7e87101fd9ee5de@squawfish.redistogo.com:9313/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)