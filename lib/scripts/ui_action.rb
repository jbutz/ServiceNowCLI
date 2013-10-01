require "nori"


class UiAction
	attr_accessor :action_name, :active, :client, :comments, :condition, :form_action, :form_button, :form_context_menu, :form_link, :hint, :list_action, :list_banner_button, :list_button, :list_choice, :list_context_menu, :list_link, :list_save_with_form_button, :name, :onclick, :order, :script, :show_insert, :show_multiple_update, :show_query, :show_update, :sys_created_by, :sys_created_on, :sys_domain, :sys_id, :sys_mod_count, :sys_overrides, :sys_updated_by, :sys_updated_on, :table

	def initialize(rec)
		@action_name                = rec['action_name']
		@active                     = rec['active']
		@client                     = rec['client']
		@comments                   = rec['comments']
		@condition                  = rec['condition']
		@form_action                = rec['form_action']
		@form_button                = rec['form_button']
		@form_context_menu          = rec['form_context_menu']
		@form_link                  = rec['form_link']
		@hint                       = rec['hint']
		@list_action                = rec['list_action']
		@list_banner_button         = rec['list_banner_button']
		@list_button                = rec['list_button']
		@list_choice                = rec['list_choice']
		@list_context_menu          = rec['list_context_menu']
		@list_link                  = rec['list_link']
		@list_save_with_form_button = rec['list_save_with_form_button']
		@name                       = rec['name']
		@onclick                    = rec['onclick']
		@order                      = rec['order']
		@script                     = rec['script']
		@show_insert                = rec['show_insert']
		@show_multiple_update       = rec['show_multiple_update']
		@show_query                 = rec['show_query']
		@show_update                = rec['show_update']
		@sys_created_by             = rec['sys_created_by']
		@sys_created_on             = rec['sys_created_on']
		@sys_domain                 = rec['sys_domain']
		@sys_id                     = rec['sys_id']
		@sys_mod_count              = rec['sys_mod_count']
		@sys_overrides              = rec['sys_overrides']
		@sys_updated_by             = rec['sys_updated_by']
		@sys_updated_on             = rec['sys_updated_on']
		@table                      = rec['table']


		@name_true = @name
		@name = "NO_NAME_" + @sys_id unless @name
	end

	def header
		"/*!\n" +
		" * Sys Id: #{@sys_id}\n" +
		" * Type: UI Action\n" +
		" * Name: #{@name_true}\n" +
		" * Created: #{@sys_created_on} by #{@sys_created_by}\n" +
		" * Updated: #{@sys_updated_on} by #{@sys_updated_by}\n" +
		" * Table: #{@table}\n" +
		" * Order: #{@order}\n" +
		" * Action name: #{@action_name}\n" +
		" * Active: #{@active}\n" +
		" * Show insert: #{@show_insert}\n" +
		" * Show update: #{@show_update}\n" +
		" * Client: #{@client}\n" +
		" * Overrides: #{@sys_overrides}\n" +
		" * Form button: #{@form_button}\n" +
		" * Form context menu: #{@form_context_menu}\n" +
		" * Form link: #{@form_link}\n" +
		" * List banner button: #{@list_banner_button}\n" +
		" * List button: #{@list_button}\n" +
		" * List context menu: #{@list_context_menu}\n" +
		" * List choice: #{@list_choice}\n" +
		" * List link: #{@list_link}\n" +
		" * Hint: #{@hint}\n" +
		" * OnClick: #{@onclick}\n" +
		" * Condition: #{@condition}\n" +
		" * Comments: #{@comments}\n" +
		" */"
	end

	def save
		heading = header()
		if @name
			file_name = @name.gsub(/[^\w\.]/, '_')
			if File.open("#{file_name}.ua.js", 'w') { |file| file.write("#{heading}\n#{@script}") }
				"Saved #{file_name}.ua.js"
			else
				"Error while saving #{@name}.ua.js"
			end
		end

	end
end