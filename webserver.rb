require 'libuv'

def generate_response request_hash
    response_hash = {}
    if request_hash.has_key?("Host")
        response_hash["Host"] = request_hash["Host"]
    end
end

def send_to_browser url
    page = url.gsub('HTTP','').strip
    
    if page == ""
        page = "index.html"
    elsif page == "index.html"
        page = "index.html"
    else page = "404.html"
    end
    
    file = File.open(page, 'r')
    return content = file.read()       
end

def start_server
    server = TCPServer.new('localhost', 3000)
    
    while connection = server.accept
        request_hash = {}
        request = connection.gets.chomp
        method, url, version = request.split('/')
        while true
            request = connection.gets
            key,value = request.split(':')
            break if request == "\r\n"
            request_hash[key] = value
        end

        generate_response(request_hash)
        connection.puts(send_to_browser(url))
        connection.close
    end
end

start_server
