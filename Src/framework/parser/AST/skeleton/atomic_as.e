note
	description:"Atomic node: strings, integers, reals etc. %
				%Version for Bench version."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ATOMIC_AS

inherit
	EXPR_AS

feature -- Properties

	is_unique: BOOLEAN
			-- Is the terminal a unique constant ?
		do
			-- Do nothing
		end

	is_id: BOOLEAN
			-- Is the atomic an id value ?
		do
			-- Do nothing
		end

feature -- Output

	string_value_32: STRING_32
		do
			if attached string_value as l_str then
				Result := encoding_converter.utf8_to_utf32 (l_str)
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Output

	string_value: STRING
		deferred
		end;


note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ATOMIC_AS
