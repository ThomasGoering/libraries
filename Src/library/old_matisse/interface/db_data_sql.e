indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Access: SQL, structure
	Product: EiffelStore
	Database: RDBMS

deferred class DB_DATA_SQL

inherit

	DB_DATA

feature  -- Status report

	count: INTEGER is
			-- Number of columns in result
		deferred
		end

	map_table: ARRAY [INTEGER] is
			-- Correspondance table between column
			-- rank and attribute rank in mapped object
		deferred
		end

	column_name (index: INTEGER): STRING is
			-- Name of the `index-th' column
		deferred
		end

	item (index: INTEGER): ANY is
			-- Data at `index-th' column
		deferred
		end

feature -- Status setting

	update_map_table (object: ANY) is
			-- Update map table according to field names of `object'.
		deferred
		end

	fill_in (no_descriptor: INTEGER) is
			-- Fill in attributes of Current with results obtained
			-- from server after execution of query statement.
		deferred
		end

feature {NONE} -- Status report

	value: ARRAY [ANY] is
			-- Array of values corresponding to a tuple
		deferred
		end

	value_size: ARRAY [INTEGER] is
			-- Array of result value size for each column
		deferred
		end

	value_type: ARRAY [INTEGER] is
			-- Array of column result type coded according to Eiffel conventions
		deferred
		end

	select_name: ARRAY [STRING] is
			-- Array of selected column names listed in select clause
		deferred
		end

end -- class DB_DATA_SQL



--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
