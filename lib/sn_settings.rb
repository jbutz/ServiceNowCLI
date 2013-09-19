$: << File.expand_path("../lib/", __FILE__)
require 'yaml'
require 'highline/import'

class SnSettings
	attr_accessor :base_url, :username, :password
	def initialize
		config_file = File.join(Dir.home(), ".sncli")
		if File.exists?( config_file )
			config = YAML.load_file( config_file )

			@base_url = config['sn_url'] if config['sn_url']
			@username = config['username'] if config['username']
			@password = config['password'] if config['password']
		end
	end

	def get_config
		@base_url = HighLine::ask("What is your ServiceNow Instance URL?") unless @base_url
		@username = HighLine::ask("What is your ServiceNow Username?") unless @username
		@password = HighLine::ask("What is your ServiceNow Password?") { |q| q.echo = '*' } unless @password
		{
			:base_url => @base_url,
			:username => @username,
			:password => @password
		}
	end
end
