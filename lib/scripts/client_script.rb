require "nori"


class ClientScript
	attr_accessor :active, :applies_extended, :condition, :description, :field, :global, :messages, :name, :script, :sys_class_name, :sys_created_by, :sys_created_on, :sys_doman, :sys_id, :sys_mod_count, :sys_updated_by, :sys_updated_on, :table, :type, :view

	def initialize(rec)
		@active           = rec['active']
		@applies_extended = rec['applies_extended']
		@condition        = rec['condition']
		@description      = rec['description']
		@field            = rec['field']
		@global           = rec['global']
		@messages         = rec['messages']
		@name             = rec['name']
		@script           = rec['script']
		@sys_class_name   = rec['sys_class_name']
		@sys_created_by   = rec['sys_created_by']
		@sys_created_on   = rec['sys_created_on']
		@sys_doman        = rec['sys_doman']
		@sys_id           = rec['sys_id']
		@sys_mod_count    = rec['sys_mod_count']
		@sys_updated_by   = rec['sys_updated_by']
		@sys_updated_on   = rec['sys_updated_on']
		@table            = rec['table']
		@type             = rec['type']
		@view             = rec['view']

		@name_true = @name
		@name = "NO_NAME_" + @sys_id unless @name
	end

	def header
		"/*!\n" +
		" * Sys Id: #{@sys_id}\n" +
		" * Type: Client Script\n" +
		" * Name: #{@name_true}\n" +
		" * Created: #{@sys_created_on} by #{@sys_created_by}\n" +
		" * Updated: #{@sys_updated_on} by #{@sys_updated_by}\n" +
		" * Table: #{@table}\n" +
		" * Type: #{@type}\n" +
		" * Inherited: #{@applies_extended}\n" + 
		" * Condition: #{@condition}\n" +
		" * Description: #{@description}\n" +
		" * Messages: #{@messages}\n" +
		" */"
	end

	def save
		heading = header()
		if @name
			file_name = @name.gsub(/[^\w\.]/, '_')
			if File.open("#{file_name}.cs.js", 'w') { |file| file.write("#{heading}\n#{@script}") }
				"Saved #{file_name}.cs.js"
			else
				"Error while saving #{@name}.cs.js"
			end
		end

	end
end