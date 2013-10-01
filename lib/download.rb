$: << File.expand_path("../lib/", __FILE__)
require "thor"
require 'sn_download'
require 'scripts/business_rule'
require 'scripts/client_script'
require 'scripts/ui_action'
require 'sn_settings'

class Download < Thor
	include Thor::Actions
	desc "br TABLE", "download all business rules from TABLE to the current directory"
	
	def br(table)
		config = SnSettings.new().get_config()

		sn = SnDownload.new(config)
		obj = sn.business_rule(table)

		if obj["xml"]
			obj = obj["xml"]
			obj["sys_script"].each do |x|
				br = BusinessRule.new(x)
				say br.save
			end
		end
	end

	desc "cs TABLE", "download all client scripts from TABLE to the current directory"
	def cs(table)
		config = SnSettings.new().get_config()

		sn = SnDownload.new(config)
		obj = sn.client_script(table)

		if obj["xml"]
			obj = obj["xml"]
			obj["sys_script_client"].each do |x|
				cs = ClientScript.new(x)
				say cs.save
			end
		end
	end

	desc "ua TABLE", "download all UI actions from TABLE to the current directory"
	def ua(table)
		config = SnSettings.new().get_config()

		sn = SnDownload.new(config)
		obj = sn.ui_action(table)

		if obj["xml"]
			obj = obj["xml"]
			obj["sys_ui_action"].each do |x|
				ua = UiAction.new(x)
				say ua.save
			end
		end
	end

end