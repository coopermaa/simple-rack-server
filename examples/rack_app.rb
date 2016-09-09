require "rack"
require "server"

inner_app = lambda do |env|
  [ 200,
    {"Content-Type" => "text/html"},
    File.open("public/index.html", File::RDONLY)
  ]
end

app = Rack::Static.new(inner_app,
        :urls => ["/images"],
        :root => "public")
server = Server.new(app)
server.start
