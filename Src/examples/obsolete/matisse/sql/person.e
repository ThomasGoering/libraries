
note
	description: "Generated by MATISSE ODL tool (release 4.0.0 of mt_odl)"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"

class 
	PERSON

inherit

-- BEGIN generation of inheritance by mt_odl
-- DO NOT MODIFY UNTIL THE 'END of mt_odl generation' MARK BELOW
	MT_STORABLE
-- END of mt_odl generation of inheritance


create
	make_from_name

feature

	make_from_name(a_first_name: STRING; middle: CHARACTER; a_last_name: STRING)
		do
			first_name := clone(a_first_name)
			middle_initial := middle
			last_name := clone(a_last_name)
		end
		
-- BEGIN generation of accessors by mt_odl
-- DO NOT MODIFY UNTIL THE 'END of mt_odl generation' MARK BELOW
-- generated with release 4.0.0 of mt_odl (c) from ADB MATISSE
-- Date: Fri Oct 23 17:10:47 1998

feature {NONE}

	last_name: STRING
	middle_initial: CHARACTER
	first_name: STRING
	spouse: PERSON
	is_in_charge_of: MT_LINKED_LIST[PRESIDENCY]

feature -- Access

	get_last_name: STRING
		do
			if is_obsolete or else last_name = Void then
				last_name := mt_get_string_by_position(field_position_of_last_name)
			end
			Result := last_name
		end

	get_middle_initial: CHARACTER
		do
			if is_obsolete or else middle_initial = Character_default_value then
				middle_initial := mt_get_character_by_position(field_position_of_middle_initial)
			end
			Result := middle_initial
		end

	get_first_name: STRING
		do
			if is_obsolete or else first_name = Void then
				first_name := mt_get_string_by_position(field_position_of_first_name)
			end
			Result := first_name
		end

	get_spouse: PERSON
		do
			if is_obsolete or else spouse = Void then
				spouse ?= mt_get_successor_by_position(field_position_of_spouse)
			end
			Result := spouse
		end

	get_is_in_charge_of: LINKED_LIST[PRESIDENCY]
		do
			if is_persistent then
				is_in_charge_of.load_successors
			end
			Result := is_in_charge_of
		end


feature -- Modification

	set_last_name(new_last_name: STRING)
		do
			last_name := clone(new_last_name)
			mt_set_string(field_position_of_last_name)
		end

	set_middle_initial(new_middle_initial: CHARACTER)
		do
			middle_initial := new_middle_initial
			mt_set_character(field_position_of_middle_initial)
		end

	set_first_name(new_first_name: STRING)
		do
			first_name := clone(new_first_name)
			mt_set_string(field_position_of_first_name)
		end

	set_spouse(new_spouse: PERSON)
		do
			check_persistence(new_spouse)
			spouse := new_spouse
			mt_set_successor(field_position_of_spouse)
		end


feature {NONE} -- Implementation

	field_position_of_last_name: INTEGER
		once
			Result := field_position_of("last_name")
		end

	field_position_of_middle_initial: INTEGER
		once
			Result := field_position_of("middle_initial")
		end

	field_position_of_first_name: INTEGER
		once
			Result := field_position_of("first_name")
		end

	field_position_of_spouse: INTEGER
		once
			Result := field_position_of("spouse")
		end


-- END of mt_odl generation of accessors

--
-- You may add your own code here...
--

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


end -- class PERSON

