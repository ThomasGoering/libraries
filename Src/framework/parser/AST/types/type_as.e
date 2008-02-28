indexing

	description: "Abstract class for Eiffel types. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TYPE_AS

inherit
	AST_EIFFEL

feature -- Roundtrip

	lcurly_symbol_index, rcurly_symbol_index: INTEGER
			-- Index in a match list for tokens.

	lcurly_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Left curly symbol(s) associated with this structure if any.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := lcurly_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	rcurly_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Right curly symbol(s) associated with this structure
			-- Maybe none, or maybe only left curly appears.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rcurly_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Settings

	set_lcurly_symbol (s_as: SYMBOL_AS) is
			-- Set `lcurly_symbol' with `s_as'.
		do
			if s_as /= Void then
				lcurly_symbol_index := s_as.index
			end
		ensure
			lcurly_symbol_index_set: s_as /= Void implies lcurly_symbol_index = s_as.index
		end

	set_rcurly_symbol (s_as: SYMBOL_AS) is
			-- Set `rcurly_symbol' with `s_as'.
		do
			if s_as /= Void then
				rcurly_symbol_index := s_as.index
			end
		ensure
			rcurly_symbol_index_set: s_as /= Void implies rcurly_symbol_index = s_as.index
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and lcurly_symbol_index /= 0 then
				Result := lcurly_symbol (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and rcurly_symbol_index /= 0 then
				Result := rcurly_symbol (a_list)
			end
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class TYPE_AS
