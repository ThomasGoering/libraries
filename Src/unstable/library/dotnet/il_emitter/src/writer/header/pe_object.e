note
	description: "Summary description for {PE_OBJECT}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_OBJECT

inherit

	ANY
		redefine
			default_create
		end


feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create name.make (8)
			create reserved.make_filled (0, 1, 3)
		end

feature -- Access

	name: STRING assign set_name
		-- Size 8.

	virtual_size: INTEGER assign set_virtual_size

	virtual_addr: INTEGER assign set_virtual_addr

	raw_size: INTEGER assign set_raw_size

	raw_ptr: INTEGER assign set_raw_ptr

	reserved: ARRAY [INTEGER]

	flags: INTEGER assign set_flags

feature -- Element Change

	set_name (a_name: like name)
			-- Set `name` with `a_name`.	
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_virtual_size (a_size: like virtual_size)
			-- Set `virtual_size` with `a_size`.
		do
			virtual_size := a_size
		ensure
			virtual_size_set: virtual_size = a_size
		end

	set_virtual_addr (a_val: like virtual_addr)
			-- Set `virtual_addr` with `a_val`.
		do
			virtual_addr := a_val
		ensure
			virtual_addr_set: virtual_addr = a_val
		end

	set_raw_size (a_size: like raw_size)
			-- Set `raw_size` with `a_size`.
		do
			raw_size := a_size
		ensure
			raw_size_set: raw_size = a_size
		end

	set_raw_ptr (a_ptr: like raw_ptr)
			-- Set `raw_ptr` with `a_ptr`
		do
			raw_ptr := a_ptr
		ensure
			raw_ptr_set: raw_ptr = a_ptr
		end

	set_flags (a_flags: like flags)
			-- Set `flags` with `a_flags`.
		do
			flags := a_flags
		ensure
			flags_set: flags = a_flags
		end
end
