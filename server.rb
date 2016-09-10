require "socket"

class Server
  STATUS_CODES = {200 => 'OK', 500 => 'Internal Server Error'}

  def initialize(app)
    @app = app
  end

  def start
    @tcp_server = TCPServer.new('0.0.0.0', ENV["PORT"] || 8080)
    puts "Listening on port #{ENV['PORT']  || 8080}..."

    loop do
      socket = nil
      begin
        socket   = @tcp_server.accept
        request_line  = socket.gets

        env = new_env(*request_line.split)
        status, headers, body = @app.call(env)

        socket.print "HTTP/1.1 #{status} #{STATUS_CODES[status]}\r\n"
        headers.each { |k, v| socket.print "#{k}: #{v}\r\n" }
        socket.print "\r\n"
      
        body.each { |chunk| socket.print chunk }
        socket.close
      rescue Exception => e
        puts "#{e.class}: #{e.message}"
        socket.close
        retry
      end
    end
  end

  def new_env(method, location, *args)
    {
      'REQUEST_METHOD'   => method,
      'SCRIPT_NAME'      => '',
      'PATH_INFO'        => location,
      'QUERY_STRING'     => location.split('?').last,
      'SERVER_NAME'      => 'localhost',
      'SERVER_PORT'      => '8080',
      'rack.version'     => [0, 1],
      'rack.url_scheme'  => 'http',
      'rack.input'       => StringIO.new(''),
      'rack.errors'      => StringIO.new(''),
      'rack.multithread' => false,
      'rack.run_once'    => false
    }
  end
end
