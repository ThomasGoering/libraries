note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IDATA_OBJECT_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	get_data_user_precondition (pformatetc_in: TAG_FORMATETC_RECORD; p_medium: STGMEDIUM_RECORD): BOOLEAN
			-- User-defined preconditions for `get_data'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_data_here_user_precondition (p_formatetc: TAG_FORMATETC_RECORD; p_medium: STGMEDIUM_RECORD): BOOLEAN
			-- User-defined preconditions for `get_data_here'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	query_get_data_user_precondition (p_formatetc: TAG_FORMATETC_RECORD): BOOLEAN
			-- User-defined preconditions for `query_get_data'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_canonical_format_etc_user_precondition (pformatect_in: TAG_FORMATETC_RECORD; pformatetc_out: TAG_FORMATETC_RECORD): BOOLEAN
			-- User-defined preconditions for `get_canonical_format_etc'.
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

	enum_format_etc_user_precondition (dw_direction: INTEGER; ppenum_format_etc: CELL [IENUM_FORMATETC_INTERFACE]): BOOLEAN
			-- User-defined preconditions for `enum_format_etc'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	dadvise_user_precondition (p_formatetc: TAG_FORMATETC_RECORD; advf: INTEGER; p_adv_sink: IADVISE_SINK_INTERFACE; pdw_connection: INTEGER_REF): BOOLEAN
			-- User-defined preconditions for `dadvise'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	dunadvise_user_precondition (dw_connection: INTEGER): BOOLEAN
			-- User-defined preconditions for `dunadvise'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enum_dadvise_user_precondition (ppenum_advise: CELL [IENUM_STATDATA_INTERFACE]): BOOLEAN
			-- User-defined preconditions for `enum_dadvise'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	get_data (pformatetc_in: TAG_FORMATETC_RECORD; p_medium: STGMEDIUM_RECORD)
			-- No description available.
			-- `pformatetc_in' [in].  
			-- `p_medium' [out].  
		require
			non_void_pformatetc_in: pformatetc_in /= Void
			valid_pformatetc_in: pformatetc_in.item /= default_pointer
			non_void_p_medium: p_medium /= Void
			valid_p_medium: p_medium.item /= Void
			get_data_user_precondition: get_data_user_precondition (pformatetc_in, p_medium)
		deferred
		end

	get_data_here (p_formatetc: TAG_FORMATETC_RECORD; p_medium: STGMEDIUM_RECORD)
			-- No description available.
			-- `p_formatetc' [in].  
			-- `p_medium' [in, out].  
		require
			non_void_p_formatetc: p_formatetc /= Void
			valid_p_formatetc: p_formatetc.item /= default_pointer
			non_void_p_medium: p_medium /= Void
			valid_p_medium: p_medium.item /= Void
			get_data_here_user_precondition: get_data_here_user_precondition (p_formatetc, p_medium)
		deferred
		end

	query_get_data (p_formatetc: TAG_FORMATETC_RECORD)
			-- No description available.
			-- `p_formatetc' [in].  
		require
			non_void_p_formatetc: p_formatetc /= Void
			valid_p_formatetc: p_formatetc.item /= default_pointer
			query_get_data_user_precondition: query_get_data_user_precondition (p_formatetc)
		deferred

		end

	get_canonical_format_etc (pformatect_in: TAG_FORMATETC_RECORD; pformatetc_out: TAG_FORMATETC_RECORD)
			-- No description available.
			-- `pformatect_in' [in].  
			-- `pformatetc_out' [out].  
		require
			non_void_pformatect_in: pformatect_in /= Void
			valid_pformatect_in: pformatect_in.item /= default_pointer
			non_void_pformatetc_out: pformatetc_out /= Void
			valid_pformatetc_out: pformatetc_out.item /= default_pointer
			get_canonical_format_etc_user_precondition: get_canonical_format_etc_user_precondition (pformatect_in, pformatetc_out)
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

	enum_format_etc (dw_direction: INTEGER; ppenum_format_etc: CELL [IENUM_FORMATETC_INTERFACE])
			-- No description available.
			-- `dw_direction' [in].  
			-- `ppenum_format_etc' [out].  
		require
			non_void_ppenum_format_etc: ppenum_format_etc /= Void
			enum_format_etc_user_precondition: enum_format_etc_user_precondition (dw_direction, ppenum_format_etc)
		deferred

		ensure
			valid_ppenum_format_etc: ppenum_format_etc.item /= Void
		end

	dadvise (p_formatetc: TAG_FORMATETC_RECORD; advf: INTEGER; p_adv_sink: IADVISE_SINK_INTERFACE; pdw_connection: INTEGER_REF)
			-- No description available.
			-- `p_formatetc' [in].  
			-- `advf' [in].  
			-- `p_adv_sink' [in].  
			-- `pdw_connection' [out].  
		require
			non_void_p_formatetc: p_formatetc /= Void
			valid_p_formatetc: p_formatetc.item /= default_pointer
			non_void_pdw_connection: pdw_connection /= Void
			dadvise_user_precondition: dadvise_user_precondition (p_formatetc, advf, p_adv_sink, pdw_connection)
		deferred

		end

	dunadvise (dw_connection: INTEGER)
			-- No description available.
			-- `dw_connection' [in].  
		require
			dunadvise_user_precondition: dunadvise_user_precondition (dw_connection)
		deferred

		end

	enum_dadvise (ppenum_advise: CELL [IENUM_STATDATA_INTERFACE])
			-- No description available.
			-- `ppenum_advise' [out].  
		require
			non_void_ppenum_advise: ppenum_advise /= Void
			enum_dadvise_user_precondition: enum_dadvise_user_precondition (ppenum_advise)
		deferred

		ensure
			valid_ppenum_advise: ppenum_advise.item /= Void
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




end -- IDATA_OBJECT_INTERFACE

