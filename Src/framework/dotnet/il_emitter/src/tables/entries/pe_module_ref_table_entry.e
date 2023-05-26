note
	description: "Object representing the ModuleRef table"
	date: "$Date$"
	revision: "$Revision$"
	see: "II.22.31 ModuleRef : 0x1A"
class
	PE_MODULE_REF_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_name_index: NATURAL_64)
		do
			create name_index.make_with_index(a_name_index)
		end

feature -- Access

	name_index: PE_STRING

feature -- Operations

	table_index: INTEGER
		once
			Result := {PE_TABLES}.tModuleref
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		do
			Result := name_index.render (a_sizes, a_dest, 0)
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		do
			Result := name_index.get (a_sizes, a_src, 0)
		end

end
