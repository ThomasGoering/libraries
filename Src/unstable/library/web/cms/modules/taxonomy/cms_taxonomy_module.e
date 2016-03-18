note
	description: "[
			Taxonomy module managing vocabularies and terms.
		]"
	date: "$Date$"
	revision: "$Revision 96616$"

class
	CMS_TAXONOMY_MODULE

inherit
	CMS_MODULE
		rename
			module_api as taxonomy_api
		redefine
			setup_hooks,
			initialize,
			install,
			uninstall,
			taxonomy_api,
			permissions
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Taxonomy solution"
			package := "core"
--			put_dependency ({CMS_NODE_MODULE}, False)
		end

feature -- Access

	name: STRING = "taxonomy"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("admin taxonomy")
			Result.force ("update any taxonomy")
			Result.force ("update page taxonomy") -- related to node module
			Result.force ("update blog taxonomy") -- related to blog module
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)
			create taxonomy_api.make (api)
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			voc: CMS_VOCABULARY
			l_taxonomy_api: like taxonomy_api
		do
				-- Schema
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)
				if l_sql_storage.has_error then
					api.logger.put_error ("Could not install database for taxonomy module", generating_type)
				else
					Precursor (api)

						-- Populate
					create l_taxonomy_api.make (api)
					create voc.make ("Tags")
					voc.set_description ("Enter comma separated tags.")
					l_taxonomy_api.save_vocabulary (voc)
					voc.set_is_tags (True)
					l_taxonomy_api.associate_vocabulary_with_type (voc, "page")
				end
			end
		end

	uninstall (api: CMS_API)
			-- (export status {CMS_API})
		do
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("uninstall").appended_with_extension ("sql")), Void)
				if l_sql_storage.has_error then
					api.logger.put_error ("Could not remove database for taxonomy module", generating_type)
				end
			end
			Precursor (api)
		end

feature {CMS_API} -- Access: API

	taxonomy_api: detachable CMS_TAXONOMY_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached taxonomy_api as l_taxonomy_api then
				configure_web (a_api, l_taxonomy_api, a_router)
				configure_web_amin (a_api, l_taxonomy_api, a_router)
			else
					-- Issue with api/dependencies,
					-- thus Current module should not be used!
					-- thus no url mapping
			end
		end

	configure_web (a_api: CMS_API; a_taxonomy_api: CMS_TAXONOMY_API; a_router: WSF_ROUTER)
			-- Configure router mapping for web interface.
		local
			l_taxonomy_handler: TAXONOMY_HANDLER
			l_voc_handler: TAXONOMY_VOCABULARY_HANDLER
		do
			create l_taxonomy_handler.make (a_api, a_taxonomy_api)
			a_router.handle ("/taxonomy/term/{termid}", l_taxonomy_handler, a_router.methods_get)

			create l_voc_handler.make (a_api, a_taxonomy_api)
			a_router.handle ("/taxonomy/vocabulary/", l_voc_handler, a_router.methods_get)
			a_router.handle ("/taxonomy/vocabulary/{vocid}", l_voc_handler, a_router.methods_get)
		end

	configure_web_amin (a_api: CMS_API; a_taxonomy_api: CMS_TAXONOMY_API; a_router: WSF_ROUTER)
			-- Configure router mapping for web interface.
		local
			l_taxonomy_handler: TAXONOMY_TERM_ADMIN_HANDLER
			l_voc_handler: TAXONOMY_VOCABULARY_ADMIN_HANDLER
		do
			a_router.handle ("/admin/taxonomy/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_admin_taxonomy (?, ?, a_api)), a_router.methods_get)

			create l_taxonomy_handler.make (a_api, a_taxonomy_api)
			a_router.handle ("/admin/taxonomy/term/", l_taxonomy_handler, a_router.methods_get_post)
			a_router.handle ("/admin/taxonomy/term/{termid}", l_taxonomy_handler, a_router.methods_get_post)

			create l_voc_handler.make (a_api, a_taxonomy_api)
			a_router.handle ("/admin/taxonomy/vocabulary/", l_voc_handler, a_router.methods_get_post)
			a_router.handle ("/admin/taxonomy/vocabulary/{vocid}", l_voc_handler, a_router.methods_get_post)
		end

feature -- Handler

	handle_admin_taxonomy (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
		local
			l_page: CMS_RESPONSE
			lnk: CMS_LOCAL_LINK
		do
			create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
			create lnk.make ("Admin Vocabularies", "admin/taxonomy/vocabulary/")
			l_page.add_to_primary_tabs (lnk)

			create lnk.make ("Create terms", "admin/taxonomy/term/")
			l_page.add_to_primary_tabs (lnk)

			l_page.execute
		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.url ("/module/" + name + "/files/css/taxonomy.css", Void), Void)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
		do
				 -- Add the link to the taxonomy to the main menu
			if a_response.has_permission ("admin taxonomy") then
				create lnk.make ("Taxonomy", "admin/taxonomy/")
				a_menu_system.management_menu.extend_into (lnk, "Admin", "admin")
			end
		end

end