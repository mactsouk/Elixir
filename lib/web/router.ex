defmodule Web.Router do
	use Plug.Router
	use Plug.Debugger

	plug Plug.Logger
    plug :match
    plug :dispatch

	def start_server do
		IO.puts "Starting Web Router!"
		:timer.sleep(100)
		{:ok, _} = Plug.Adapters.Cowboy.http Web.Router, []
	end

	def init(options) do
		options
	end
	
	def start_link do
		IO.puts "Inside start_link function"
		start_server
	end
	
	get "/" do
		conn
		|> send_resp(200, "ok")
		|> halt
	end
	
	get "/bug" do
		raise "WAT"
	end
	
	get "/hello/:name" do
		conn
		|> send_resp(200, "Hello #{name}!")
		|> halt
	end
	
	match _ do
		conn
		|> send_resp(404, "Not Found")
		|> halt
	end

end
