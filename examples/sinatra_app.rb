require "sinatra"
require "server"

set :public_folder, "public"

get '/' do
  'Hello Sinatra'
end

server = Server.new(Sinatra::Application)
server.start 
