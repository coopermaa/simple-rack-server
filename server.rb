require "socket"
 
server = TCPServer.new('0.0.0.0', 8080)
puts "Listening on port 8080..."

loop do
  socket = server.accept
  request_line = socket.gets
  socket.print "HTTP/1.1 200/OK\r\n"
  socket.print "Content-type: text/html\r\n"
  socket.print "\r\n"
  socket.print("Hello World")
  socket.close
end