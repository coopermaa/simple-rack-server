require "sinatra"
require "server"

get '/' do
  'Hello Sinatra'
end

server = Server.new(Sinatra::Application.new)
server.start 