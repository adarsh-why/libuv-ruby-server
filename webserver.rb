require 'libuv'
webserver = TCPServer.new('localhost', 3000)

def generate_response request_hash
    puts "\n HTTP response \n"
    response_hash = {}
    if request_hash.has_key?("Host")
        response_hash["Host"] = request_hash["Host"]
    end
    p response_hash
end

while connection = webserver.accept
    request_hash = {}
    request = connection.gets.chomp
    method, url, version = request.split('/')
    puts "method is #{method}"
    puts "url is #{url}"
    puts "version is #{version}"
    while true
        request = connection.gets
        key,value = request.split(':')
        break if request == "\r\n"
        request_hash[key] = value
    end

    puts "\n HTTP request \n"
    request_hash.each {|key, val| puts "#{key.chomp} : #{val}"} 
       
    generate_response(request_hash)
    connection.puts "Hi, Welcome to Libuv Server"
    connection.close
end
