require "nori"
require "digest"

class BusinessRule
	attr_accessor :name, :collection, :order, :client_callable, :active, :when, :action_insert, :action_update, :action_delete, :action_query, :condition, :script, :action_run_at, :sys_created_by, :sys_created_on, :sys_updated_by, :sys_updated_on, :sys_id

	def initialize(br)
		@name            = br["name"]
		@collection      = br["collection"]
		@order           = br["order"]
		@client_callable = br["client_callable"]
		@active          = br["active"]
		@when            = br["when"]
		@action_insert   = br["action_insert"]
		@action_update   = br["action_update"]
		@action_delete   = br["action_delete"]
		@action_query    = br["action_query"]
		@condition       = br["condition"]
		@script          = br["script"]
		@action_run_at   = br["action_run_at"]
		@sys_id          = br["sys_id"]
		@sys_created_by  = br["sys_created_by"]
		@sys_created_on  = br["sys_created_on"]
		@sys_updated_by  = br["sys_updated_by"]
		@sys_updated_on  = br["sys_updated_on"]

		@name_true = @name
		@name = "NO_NAME_" + Digest::MD5.hexdigest(@script).to_s unless @name
	end

	def header

		"/*!\n" +
		" * Sys Id: #{@sys_id}\n" +
		" * Type: Business Rule\n" +
		" * Name: #{@name_true}\n" +
		" * Created: #{@sys_created_on} by #{@sys_created_by}\n" +
		" * Updated: #{@sys_updated_on} by #{@sys_updated_by}\n" +
		" * Table: #{@collection}\n" +
		" * Order: #{@order}\n" +
		" * Client callable: #{@client_callable}\n" + 
		" * Active: #{@active}\n" +
		" * When: #{@when}\n" +
		" * Insert: #{@action_insert}\n" +
		" * Update: #{@action_update}\n" +
		" * Delete: #{@action_delete}\n" +
		" * Query: #{@action_query}\n" +
		" * Run at: #{@action_run_at}\n" +
		" * Condition: #{@condition}\n" +
		" */"
	end

	def save
		heading = header()
		if File.open("#{@name}.br.js", 'w') { |file| file.write("#{heading}\n#{@script}") }
			"Saved #{@name}.br.js"
		else
			"Error while saving #{@name}.br.js"
		end

	end
end