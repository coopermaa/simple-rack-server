# simple-rack-server

A simple Rack Web Server that demostrates how to talk to Rack applications.

## Example applications

The simplest Rack application:

```ruby
# rack_app.rb
require "server"

app = lambda do |env|
  [200, {"Content-Type" => "text/html"}, ["Hello World"]]
end

server = Server.new(app)
server.start
```

Here we use our own Web Server called **Server**.

The following Rack appliaction shows how to create a static web site:

```ruby
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
```
See examples/rack_app.rb. To run the application, type:

```
$ ruby -I. examples/rack_app.rb
```

There is also a Sinatra version, see examples/sinatra_app.rb.

## Deploying to Heroku

```sh
$ heroku create
$ git push heroku master
$ heroku open
```