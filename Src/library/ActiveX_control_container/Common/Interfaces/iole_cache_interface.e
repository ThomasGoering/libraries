note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IOLE_CACHE_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	cache_user_precondition (p_formatetc: TAG_FORMATETC_RECORD; advf: INTEGER; pdw_connection: INTEGER_REF): BOOLEAN
			-- User-defined preconditions for `cache'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	uncache_user_precondition (dw_connection: INTEGER): BOOLEAN
			-- User-defined preconditions for `uncache'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enum_cache_user_precondition (ppenum_statdata: CELL [IENUM_STATDATA_INTERFACE]): BOOLEAN
			-- User-defined preconditions for `enum_cache'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	init_cache_user_precondition (p_data_object: IDATA_OBJECT_INTERFACE): BOOLEAN
			-- User-defined preconditions for `init_cache'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_data_user_precondition (p_formatetc: TAG_FORMATETC_RECORD; pmedium: STGMEDIUM_RECORD; f_release: INTEGER): BOOLEAN
			-- User-defined preconditions for `set_data'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	cache (p_formatetc: TAG_FORMATETC_RECORD; advf: INTEGER; pdw_connection: INTEGER_REF)
			-- No description available.
			-- `p_formatetc' [in].  
			-- `advf' [in].  
			-- `pdw_connection' [out].  
		require
			non_void_p_formatetc: p_formatetc /= Void
			valid_p_formatetc: p_formatetc.item /= default_pointer
			non_void_pdw_connection: pdw_connection /= Void
			cache_user_precondition: cache_user_precondition (p_formatetc, advf, pdw_connection)
		deferred

		end

	uncache (dw_connection: INTEGER)
			-- No description available.
			-- `dw_connection' [in].  
		require
			uncache_user_precondition: uncache_user_precondition (dw_connection)
		deferred

		end

	enum_cache (ppenum_statdata: CELL [IENUM_STATDATA_INTERFACE])
			-- No description available.
			-- `ppenum_statdata' [out].  
		require
			non_void_ppenum_statdata: ppenum_statdata /= Void
			enum_cache_user_precondition: enum_cache_user_precondition (ppenum_statdata)
		deferred

		ensure
			valid_ppenum_statdata: ppenum_statdata.item /= Void
		end

	init_cache (p_data_object: IDATA_OBJECT_INTERFACE)
			-- No description available.
			-- `p_data_object' [in].  
		require
			init_cache_user_precondition: init_cache_user_precondition (p_data_object)
		deferred

		end

	set_data (p_formatetc: TAG_FORMATETC_RECORD; pmedium: STGMEDIUM_RECORD; f_release: INTEGER)
			-- No description available.
			-- `p_formatetc' [in].  
			-- `pmedium' [in].  
			-- `f_release' [in].  
		require
			non_void_p_formatetc: p_formatetc /= Void
			valid_p_formatetc: p_formatetc.item /= default_pointer
			non_void_pmedium: pmedium /= Void
			valid_pmedium: pmedium.item /= Void
			set_data_user_precondition: set_data_user_precondition (p_formatetc, pmedium, f_release)
		deferred

		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IOLE_CACHE_INTERFACE

