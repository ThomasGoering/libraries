note
	description: "Eiffel-MATISSE Binding: Example for HASH_TABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	generator: "Generated by MATISSE ODL tool (release 4.0.0 of mt_odl)";
	date: "$Date$"

class 
	ZIP_CODE

inherit

-- BEGIN generation of inheritance by mt_odl
-- DO NOT MODIFY UNTIL THE 'END of mt_odl generation' MARK BELOW
	MT_STORABLE
-- END of mt_odl generation of inheritance
		redefine out
		end
		
	ZIP_CODE_CONSTANTS
		undefine is_equal
		redefine out
		end
	
create
	make

feature -- Initialization

	make(a_zip_code: INTEGER)
		do
			zip_code := a_zip_code
			create city_names.make
			create states.make
			create zip_types.make
		end
		
-- BEGIN generation of accessors by mt_odl
-- DO NOT MODIFY UNTIL THE 'END of mt_odl generation' MARK BELOW
-- generated with release 4.0.0 of mt_odl (c) from ADB MATISSE
-- Date: Thu Oct 22 15:46:56 1998


feature {NONE}

	zip_code: INTEGER
	city_names: LINKED_LIST[STRING]
	states: LINKED_LIST[STRING]
	zip_types: LINKED_LIST[INTEGER]

feature -- Access

	get_zip_code: INTEGER
		do
			if is_obsolete or else zip_code = Integer_default_value then
				zip_code := mt_get_unsigned_integer_by_position(field_position_of_zip_code)
			end
			Result := zip_code
		end

	get_city_names: LINKED_LIST[STRING]
		do
			if is_obsolete or else city_names = Void then
				city_names := mt_get_string_list_by_position(field_position_of_city_names)
			end
			Result := city_names
		end

	get_states: LINKED_LIST[STRING]
		do
			if is_obsolete or else states = Void then
				states := mt_get_string_list_by_position(field_position_of_states)
			end
			Result := states
		end

	get_zip_types: LINKED_LIST[INTEGER]
		do
			if is_obsolete or else zip_types = Void then
				zip_types := mt_get_integer_list_by_position(field_position_of_zip_types)
			end
			Result := zip_types
		end


feature -- Modification

	set_zip_code(new_zip_code: INTEGER)
		do
			zip_code := new_zip_code
			mt_set_unsigned_integer(field_position_of_zip_code)
		end

	set_city_names(new_city_names: LINKED_LIST[STRING])
		do
			city_names := new_city_names
			mt_set_string_list(field_position_of_city_names)
		end

	set_states(new_states: LINKED_LIST[STRING])
		do
			states := new_states
			mt_set_string_list(field_position_of_states)
		end

	set_zip_types(new_zip_types: LINKED_LIST[INTEGER])
		do
			zip_types := new_zip_types
			mt_set_integer_list(field_position_of_zip_types)
		end


feature {NONE} -- Implementation

	field_position_of_zip_code: INTEGER
		once
			Result := field_position_of("zip_code")
		end

	field_position_of_city_names: INTEGER
		once
			Result := field_position_of("city_names")
		end

	field_position_of_states: INTEGER
		once
			Result := field_position_of("states")
		end

	field_position_of_zip_types: INTEGER
		once
			Result := field_position_of("zip_types")
		end


-- END of mt_odl generation of accessors

--
-- You may add your own code here...
--

feature -- Element change

	add_city(city_name, state_name: STRING; type: INTEGER)
		do
			city_names.extend(clone(city_name))
			states.extend(clone(state_name))
			zip_types.extend(type)
		end
	
feature -- Output

	out : STRING
		do
			create Result.make(0)
			Result.append(zip_code_out) Result.append(":%N")
			Result.append("City Name                     State     ZIP code type%N")
			Result.append("-----------------------------------------------------%N")
			from
				get_city_names.start
				get_states.start
				get_zip_types.start
			until
				city_names.off
			loop
				Result.append(city_name_out(city_names.item))
				Result.append(states.item) Result.append("        ")
				Result.append(zip_type_string(zip_types.item)) Result.append("%N")
				city_names.forth
				states.forth
				zip_types.forth
			end
			Result.append("-----------------------------------------------------%N")
		end

feature {NONE} -- Implementation

	zip_code_out : STRING
		local
			str: STRING
			n: INTEGER
		do
			str := get_zip_code.out
			from n := 5 - str.count
			until n = 0
			loop
				str.prepend_character('0')
				n := n - 1
			end
			Result := clone(str)
		end
		
	city_name_out(a_name: STRING): STRING
		local
			n: INTEGER
		do
			Result := clone(a_name)
			from n := a_name.count
			until n >= 30
			loop
				Result.append_character(' ')
				n := n + 1
			end
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


end -- class ZIP_CODE

