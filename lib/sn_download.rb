require "net/http"
require "uri"
require "nori"

class SnDownload
	attr_accessor :base_url, :username, :password

	def initialize(config)
		@base_url = config[:base_url]
		@username = config[:username]
		@password = config[:password]
	end

	def business_rule(db_table)
		download("sys_script",db_table,"collection")
	end

	def client_script(db_table)
		download("sys_script_client",db_table,"table")
	end

	def ui_action(db_table)
		download("sys_ui_action",db_table,"table")
	end



	private
	def download(script_table, db_table, tbl_field)
		uri = URI.parse(@base_url + "/#{script_table}.do?XML&sysparm_query=#{tbl_field}%3D#{db_table}")

		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(uri.request_uri)
		request.basic_auth(@username, @password)
		response = http.request(request)

		if response.code == "401"
			raise Exception.new("Authentication failed")
		elsif response.code != "200"
			puts response.code
			raise Exception.new("HTTP Error")
		else
			parser = Nori.new
			parser.parse(response.body)
		end
	end
end