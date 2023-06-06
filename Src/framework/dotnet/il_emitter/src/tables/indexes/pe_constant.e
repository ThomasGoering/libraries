note
	description: "A possible index type that occur in the tables we are interested in."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CONSTANT

inherit

	PE_INDEX_BASE
		rename
			make as make_base
		redefine
			get_index_shift,
			has_index_overflow
		end

create
	make_with_tag_and_index

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Enum: tags

	TagBits: INTEGER = 2
			-- HasConstant
			-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=299&zoom=100,116,96
			
	FieldDef: INTEGER = 0
	ParamDef: INTEGER = 1
			--TagProperty : INTEGER =2
			-- TODO double check why TagProperty is not used.
feature -- Operations

	get_index_shift: INTEGER
		do
			Result := tagbits
		end

	has_index_overflow (a_sizes: ARRAY [NATURAL_64]): BOOLEAN
		do
			Result := large (a_sizes [{PE_TABLES}.tField.to_integer_32 + 1].to_natural_32) or else
				large (a_sizes [{PE_TABLES}.tParam.to_integer_32 + 1].to_natural_32)
		end

end
