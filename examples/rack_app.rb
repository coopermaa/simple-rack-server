require "server"

app = lambda do |env|
  [200, {"Content-Type" => "text/html"}, ["Hello World"]]
end

server = Server.new(app)
server.start