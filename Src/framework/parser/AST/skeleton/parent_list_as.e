indexing
	description: "Object that represents a list of PARENT_AS nodes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARENT_LIST_AS

inherit
	EIFFEL_LIST [PARENT_AS]
		redefine
			process, first_token, last_token
		end

create
	make,
	make_filled

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_parent_list_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				check
					inherit_keyword /= Void
				end
				Result := inherit_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				Result := Precursor (a_list)
				if Result = Void or else Result.is_null then
					Result := inherit_keyword.last_token (a_list)
				end
			end
		end

feature -- Roundtrip

	inherit_keyword: KEYWORD_AS
			-- Keyword "inherit" associated with current AST node.

	left_curly_symbol: SYMBOL_AS
			-- Symbol '{' associated with current AST node if non-conforming inheritance is specified.

	none_id_as: ID_AS
			-- 'NONE' ID_AS used for specifying non-conforming inheritance.

	right_curly_symbol: SYMBOL_AS
			-- Symbol '}' associated with current AST node if non-conforming inheritance is specified.

	set_inheritance_tokens (a_inherit_keyword: like inherit_keyword; a_left_curly_symbol: like left_curly_symbol; a_none_id_as: like none_id_as; a_right_curly_symbol: like right_curly_symbol) is
			-- Set tokens associated with inheritance clause.
		do
			inherit_keyword := a_inherit_keyword
			left_curly_symbol := a_left_curly_symbol
			none_id_as := a_none_id_as
			right_curly_symbol := a_right_curly_symbol
		ensure
			inherit_keyword_set: inherit_keyword = a_inherit_keyword
			left_curly_symbol_set: left_curly_symbol = a_left_curly_symbol
			right_curly_symbol_set: right_curly_symbol = a_right_curly_symbol
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
end
