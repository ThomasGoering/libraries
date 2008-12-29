note
	description: "Ingres specification"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	INGRES

inherit
	DATABASE
		redefine
			has_row_number,
			sensitive_mixed,
			parse,
			map_var_between_2,
			proc_args
		end
		
	STRING_HANDLER

feature -- Access

	database_handle_name: STRING = "INGRES"

feature -- For DATABASE_STATUS

	is_error_updated: BOOLEAN
			-- Has an Oracle function been called since last update which may have
			-- updated error code, error message or warning message?

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?

	clear_error
			-- Reset database error status.
		do
		end

	insert_auto_identity_column: BOOLEAN
			-- For INSERTs and UPDATEs should table auto-increment identity columns be explicitly included in the statement?
		do
			check
				to_be_implemented: False
			end
		end

feature -- For DATABASE_CHANGE


feature -- For DATABASE_CHANGE 

	descriptor_is_available: BOOLEAN = True

feature -- For DATABASE_FORMAT
	
	date_to_str (object: DATE_TIME): STRING
			-- String representation in SQL of `object'
		do
			Result := object.formatted_out("mm/dd/yyyy [0]hh:[0]mi:[0]ss")
			Result.precede ('%'')
			Result.extend ('%'')
		end
	
	string_format (object: STRING): STRING
			-- String representation in SQL of `object'
		do
			Result := object
			Result.precede ('%'')
			Result.extend ('%'')
		end

	True_representation: STRING = "%'1%'"

	False_representation: STRING = "%'0%'"

feature -- For DATABASE_SELECTION, DATABASE_CHANGE, DATABASE_PROC

	normal_parse: BOOLEAN 
		do
			if is_proc then
				Result := False
				is_proc := False
			else
				Result := True
			end
		end

	parse (descriptor: INTEGER; uht: HASH_TABLE [ANY, STRING]; ht_order: ARRAYED_LIST [STRING]; uhandle: HANDLE; sql: STRING): BOOLEAN
		do
			Result := true
		end

feature -- Access

	last_error_code: INTEGER
			-- Last error returned by Handle.

	get_error_code: INTEGER
		do
			Result := last_error_code
		end

feature -- DATABASE_STRING

	sql_name_string: STRING
		once
			Result := "char(255)"
		ensure then
			Result.is_equal ("char(255)")
		end

feature -- DATABASE_REAL

	sql_name_real: STRING
		once
			Result := "real"
		ensure then
			Result.is_equal ("real")
		end

feature -- DATABASE_DATETIME

	sql_name_datetime: STRING
		once
			Result := "date"
		ensure then
			Result.is_equal ("date")
		end

feature -- DATABASE_DOUBLE

	sql_name_double: STRING
		once
			Result := "float"
		ensure then
			Result.is_equal ("float")
		end

feature -- DATABASE_CHARACTER

	sql_name_character: STRING
		once
			Result := "char(1)"
		ensure then
			Result.is_equal ("char(1)")
		end

feature -- DATABASE_INTEGER

	sql_name_integer: STRING
		once
			Result := "int"
		ensure then
			Result.is_equal ("int")
		end

feature -- DATABASE_BOOLEAN

	sql_name_boolean: STRING
		once
			Result := "text"
		ensure then
			textual_outlook: Result.is_equal ("text")
		end

feature -- LOGIN and DATABASE_APPL only for password_ok

	password_ok (upasswd: STRING): BOOLEAN
		do
			Result := True
		end

	password_ensure (name, passwd, uname, upasswd: STRING): BOOLEAN
		do
			Result := name.is_equal(uname) and passwd.is_equal(upasswd)
		end

feature -- For DATABASE_PROC

	has_row_number: BOOLEAN = True

	support_sql_of_proc: BOOLEAN = True

	support_stored_proc: BOOLEAN
		do
			Result := True
			is_proc := True
		end

	sql_as: STRING = " as begin "

	sql_end: STRING = "; end "

	sql_execution: STRING = "execute procedure "

	sql_after_exec: STRING = ""

	sql_creation: STRING = "create procedure "

	support_drop_proc: BOOLEAN = True

	name_proc_lower: BOOLEAN = True

	map_var_between: STRING = ""

	map_var_name (a_para: STRING): STRING
		do
		 	create Result.make_from_string (":")
			Result.append (a_para)
		end

	map_var_between_2: STRING = " = "

	Select_text (proc_name: STRING): STRING
		do
			Result := "select text_segment from iiprocedures where procedure_name = :name and  text_sequence = :seq"
		end

	Select_exists (name: STRING): STRING
		do
			Result := "select count(*) from %
		%iiprocedures where procedure_name = :name "
		end

	proc_args: BOOLEAN = True

feature -- For DATABASE_REPOSITORY

	sensitive_mixed: BOOLEAN = False

	Selection_string (rep_qualifier, rep_owner, repository_name: STRING): STRING
		do
			Result := " select owner = t.table_owner, t.table_name, %
		% t.table_type, c.column_name, column_id=c.column_sequence, %
		% c.column_nulls, column_typename = c.column_datatype, %
		% data_type = c.column_ingdatatype, data_length = column_length %
		% from iitables t, iicolumns c %
		% where t.table_name = c.table_name %
		% and t.table_name = :rep  order by column_id"
		end

	sql_string: STRING = "text("

	sql_string2 (int: INTEGER): STRING
		do
			Result := "text("
			Result.append(int.out)
			Result.append(")")
		end

feature -- External

	get_error_message: POINTER
		do
			Result := ing_get_error_message
		end

	get_warn_message: POINTER
		do
			Result := ing_get_warn_message
		end

	new_descriptor: INTEGER
		do
			Result := ing_new_descriptor
		end

	init_order (no_descriptor: INTEGER; command: STRING)
		local
			c_temp: C_STRING
		do
			create c_temp.make (command)
			last_error_code := ing_init_order (no_descriptor, c_temp.item)
		end

	start_order (no_descriptor: INTEGER)
		do
			last_error_code := ing_start_order(no_descriptor)
		end

	next_row (no_descriptor: INTEGER)
		do
			last_error_code := ing_next_row(no_descriptor)
		end

	terminate_order (no_descriptor: INTEGER)
		do
			last_error_code := ing_terminate_order(no_descriptor)
		end

	close_cursor (no_descriptor: INTEGER)
			-- Do nothing, for ODBC prepared statement
		do
		end

	exec_immediate (no_descriptor: INTEGER; command: STRING)
		local
			c_temp: C_STRING
		do
			create c_temp.make (command)
			last_error_code := ing_exec_immediate(c_temp.item)
		end

	put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
		local
			l_area: MANAGED_POINTER
			i: INTEGER
		do
			create l_area.make (max_len)

			Result := ing_put_col_name(no_descriptor, index, l_area.item, max_len)

			check
				Result <= max_len
			end

			ar.set_count (Result)

			from
				i := 1
			until
				i > Result
			loop
				ar.put (l_area.read_integer_8 (i - 1).to_character_8, i)
				i := i + 1
			end
		end

	put_data (no_descriptor: INTEGER; index: INTEGER; ar: STRING; max_len:INTEGER): INTEGER
		local
			l_area: MANAGED_POINTER
			i: INTEGER
		do
			create l_area.make (max_len)

			Result := ing_put_data (no_descriptor, index, l_area.item, max_len)

			check
				Result <= max_len
			end

			ar.set_count (Result)

			from
				i := 1
			until
				i > Result
			loop
				ar.put (l_area.read_integer_8 (i - 1).to_character_8, i)
				i := i + 1
			end
		end

	conv_type (indicator: INTEGER; index: INTEGER): INTEGER
		do
			Result := ing_conv_type (indicator, index)
		end

	get_count (no_descriptor: INTEGER): INTEGER
		do
			Result := ing_get_count(no_descriptor)
		end

	get_data_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_data_len (no_descriptor, ind)
		end

	get_col_len (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_col_len (no_descriptor, ind)
		end

	get_col_type (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_col_type (no_descriptor,ind)
		end

	get_integer_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_integer_data (no_descriptor, ind)
		end

	get_float_data (no_descriptor: INTEGER; ind: INTEGER): DOUBLE
		do
			Result := ing_get_float_data (no_descriptor, ind)
		end

	get_real_data (no_descriptor: INTEGER; ind: INTEGER): REAL
		do
			Result := ing_get_real_data (no_descriptor, ind)
		end

	get_boolean_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
		do
			Result := ing_get_boolean_data (no_descriptor, ind)
		end

	is_null_data (no_descriptor: INTEGER; ind: INTEGER): BOOLEAN
			-- is last retrieved data null? 
		do
		end

	get_date_data (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_date_data (no_descriptor, ind)
		end

	get_hour (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_hour
		end

	get_sec (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_sec
		end

	get_min (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_min
		end

	get_year (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_year
		end

	get_day (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_day
		end

	get_month (no_descriptor: INTEGER; ind: INTEGER): INTEGER
		do
			Result := ing_get_month
		end

	c_string_type: INTEGER
		do
			Result := ing_c_string_type
		end

	c_character_type: INTEGER
		do
			Result := ing_c_character_type
		end

	c_integer_type: INTEGER
		do
			Result := ing_c_integer_type
		end

	c_float_type: INTEGER
		do
			Result := ing_c_float_type
		end

   	c_real_type: INTEGER
		do
			Result := ing_c_real_type
       	end

	c_boolean_type: INTEGER
		do
			Result := ing_c_boolean_type
		end

	c_date_type: INTEGER
		do
			Result := ing_c_date_type
		end

	database_make (i: INTEGER)
		do
			c_ing_make (i)
		end

	connect (user_name, user_passwd, data_source, application, hostname, roleId, rolePassWd, groupId: STRING)
		local
			c_temp1, c_temp2, c_temp3, c_temp4, c_temp5, c_temp6: C_STRING
		do
			create c_temp1.make (user_name)
			create c_temp2.make (user_passwd)
			create c_temp3.make (roleId)
			create c_temp4.make (rolePassWd)
			create c_temp5.make (groupId)
			create c_temp6.make (data_source)
			last_error_code := ing_connect (c_temp1.item, c_temp2.item,
				c_temp3.item, c_temp4.item, c_temp5.item, c_temp6.item)
		end

	disconnect
		do
			last_error_code := ing_disconnect
		end

	commit
		do
			last_error_code := ing_commit
		end

	rollback
		do
			last_error_code := ing_rollback
		end

	trancount: INTEGER
		do
			Result := ing_trancount
		end

	begin
		do
			last_error_code := ing_begin
		end

feature {NONE} -- External features

	is_proc: BOOLEAN

	ing_get_error_message: POINTER
		external
			"C"
		end

	ing_get_warn_message: POINTER
		external
			"C"
		end

	ing_new_descriptor: INTEGER
		external
			"C"
		end

	ing_init_order (no_descriptor: INTEGER; command: POINTER): INTEGER
		external
			"C"
		end

	ing_start_order (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	ing_next_row (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	ing_terminate_order (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	ing_exec_immediate (command: POINTER): INTEGER
		external
			"C"
		end

	ing_put_col_name (no_descriptor: INTEGER; index: INTEGER; ar: POINTER; max_len:INTEGER): INTEGER
		external
			"C"
		end

	ing_put_data (no_descriptor: INTEGER; index: INTEGER; ar: POINTER; max_len:INTEGER): INTEGER
		external
			"C"
		end

	ing_conv_type (indicator: INTEGER; index: INTEGER): INTEGER
		external
			"C"
		end

	ing_get_count (no_descriptor: INTEGER): INTEGER
		external
			"C"
		end

	ing_get_data_len (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C"
		end

	ing_get_col_len (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C"
		end

	ing_get_col_type (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C"
		end

	ing_get_integer_data (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C"
		end

	ing_get_float_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE
		external
			"C"
		end

	ing_get_real_data (no_descriptor: INTEGER ind: INTEGER): DOUBLE
		external
			"C"
		end

	ing_get_boolean_data (no_descriptor: INTEGER ind: INTEGER): BOOLEAN
		external
			"C"
		end

	ing_get_date_data (no_descriptor: INTEGER ind: INTEGER): INTEGER
		external
			"C"
		end

	ing_get_hour: INTEGER
		external
			"C"
		end

	ing_get_sec: INTEGER
		external
			"C"
		end

	ing_get_min: INTEGER
		external
			"C"
		end

	ing_get_year: INTEGER
		external
			"C"
		end

	ing_get_day: INTEGER
		external
			"C"
		end

	ing_get_month: INTEGER
		external
			"C"
		end

	ing_c_string_type: INTEGER
		external
			"C"
		alias
			"c_string_type"
		end

	ing_c_character_type: INTEGER
		external
			"C"
		alias
			"c_character_type"
		end

	ing_c_integer_type: INTEGER
		external
			"C"
		alias
			"c_integer_type"
		end

	ing_c_float_type: INTEGER
		external
			"C"
		alias
			"c_float_type"
		end

   	ing_c_real_type: INTEGER
		external
			"C"
		alias
			"c_real_type"
        	end

	ing_c_boolean_type: INTEGER
		external
			"C"
		alias
			"c_boolean_type"
		end

	ing_c_date_type: INTEGER
		external
			"C"
		alias
			"c_date_type"
		end

	c_ing_make (i: INTEGER)
		external
			"C"
		end


	ing_disconnect: INTEGER
		external
			"C"
		end

	ing_commit: INTEGER
		external
			"C"
		end

	ing_rollback: INTEGER
		external
			"C"
		end

	ing_trancount: INTEGER
		external
			"C"
		end

	ing_begin: INTEGER
		external
			"C"
		end

	ing_connect (user_name, user_passwd, role, rolePassWd, group, dbName: POINTER): INTEGER
		external
			"C"
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




end -- class INGRES


