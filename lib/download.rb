$: << File.expand_path("../lib/", __FILE__)
require "thor"
require 'sn_download'
require 'br_object'
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
				br = BrObject.new(x)
				say br.save
			end
		end
	end
end