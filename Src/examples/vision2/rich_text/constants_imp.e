indexing
	description: "Objects that provide access to constants loaded from files."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS_IMP
	
feature {NONE} -- Initialization

	initialize_constants is
			-- Load all constants from file.
		local
			file: PLAIN_TEXT_FILE
		do
			if not constants_initialized then
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.readstream (file.count)
					file.close
					parse_file_contents (file.laststring)
				end
				initialized_cell.put (True)
			end
		ensure
			initialized: constants_initialized
		end

feature -- Access

	strike_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("strike.png")
			set_with_named_file (Result, a_file_name)
		end

	justified_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("justified.png")
			set_with_named_file (Result, a_file_name)
		end

	italic_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("italic.png")
			set_with_named_file (Result, a_file_name)
		end

	caret_position_status_bar_width: INTEGER is 
			-- `Result' is INTEGER constant named caret_position_status_bar_width.
		once
			Result := 100
		end

	left_alignment_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("left_alignment.png")
			set_with_named_file (Result, a_file_name)
		end

	tiny_padding: INTEGER is 
			-- `Result' is INTEGER constant named tiny_padding.
		once
			Result := 2
		end

	small_padding: INTEGER is 
			-- `Result' is INTEGER constant named small_padding.
		once
			Result := 4
		end

	underline_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("underline.png")
			set_with_named_file (Result, a_file_name)
		end

	window_height: INTEGER is 
			-- `Result' is INTEGER constant named window_height.
		once
			Result := 320
		end

	bold_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("bold.png")
			set_with_named_file (Result, a_file_name)
		end

	window_width: INTEGER is 
			-- `Result' is INTEGER constant named window_width.
		once
			Result := 540
		end

	right_alignment_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("right_alignment.png")
			set_with_named_file (Result, a_file_name)
		end

	font_size_combo_box_width: INTEGER is 
			-- `Result' is INTEGER constant named font_size_combo_box_width.
		once
			Result := 50
		end

	center_alignment_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (rich_text_example_root)
			a_file_name.set_file_name ("center_alignment.png")
			set_with_named_file (Result, a_file_name)
		end

	font_selection_combo_box_width: INTEGER is 
			-- `Result' is INTEGER constant named font_selection_combo_box_width.
		once
			Result := 150
		end

	rich_text_example_root: STRING is
			-- `Result' is DIRECTORY constant named `rich_text_example_root'.
		once
			Result := "E:\projects\rich_text"
		end


feature -- Access

--| FIXME `constant_by_name' and `has_constant' `constants_initialized' are only required until the complete change to
--| constants is complete. They are required for the pixmaps at the moment.

	constants_initialized: BOOLEAN is
			-- Have constants been initialized from file?
		do
			Result := initialized_cell.item
		end

	string_constant_by_name (a_name: STRING): STRING is
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			Result := clone (all_constants.item (a_name))
		ensure
			Result_not_void: Result /= Void
		end
		
	integer_constant_by_name (a_name: STRING): INTEGER is
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		local
			l_string: STRING
		do
			l_string := clone (all_constants.item (a_name))
			check
				is_integer: l_string.is_integer
			end
			
			Result := l_string.to_integer
		end
		
	has_constant (a_name: STRING): BOOLEAN is
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			Result := all_constants.item (a_name) /= Void
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN] is
			-- A cell to hold whether the constants have been loaded.
		once
			create Result
		end
		
	all_constants: HASH_TABLE [STRING, STRING] is
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end
		
	file_name: STRING is "constants.txt"
		-- File name from which constants must be loaded.
		
	String_constant: STRING is "STRING"
	
	Integer_constant: STRING is "INTEGER"
		
	parse_file_contents (content: STRING) is
			-- Parse contents of `content' into `all_constants'.
		local
			line_contents: STRING
			is_string: BOOLEAN
			is_integer: BOOLEAN
			start_quote1, end_quote1, start_quote2, end_quote2: INTEGER
			name, value: STRING
		do
			from
			until
				content.is_equal ("")
			loop
				line_contents := first_line (content)
				if line_contents.count /= 1 then
					is_string := line_contents.substring_index (String_constant, 1) /= 0
					is_integer := line_contents.substring_index (Integer_constant, 1) /= 0
					if is_string or is_integer then
						start_quote1 := line_contents.index_of ('"', 1)
						end_quote1 := line_contents.index_of ('"', start_quote1 + 1)
						start_quote2 := line_contents.index_of ('"', end_quote1 + 1)
						end_quote2 := line_contents.index_of ('"', start_quote2 + 1)
						name := line_contents.substring (start_quote1 + 1, end_quote1 - 1)
						value := line_contents.substring (start_quote2 + 1, end_quote2 - 1)
						all_constants.put (value, name)
					end
				end
			end
		end
		
	first_line (content: STRING): STRING is
			-- `Result' is first line of `Content',
			-- which will be stripped from `content'.
		require
			content_not_void: content /= Void
			content_not_empty: not content.is_empty
		local
			new_line_index: INTEGER		
		do
			new_line_index := content.index_of ('%N', 1)
			if new_line_index /= 0 then
				Result := content.substring (1, new_line_index)
				content.keep_tail (content.count - new_line_index)
			else
				Result := clone (content)
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

	set_with_named_file (a_pixmap: EV_PIXMAP; a_file_name: STRING) is
			-- Set image of `a_pixmap' from file, `a_file_name'.
			-- If `a_file_name' does not exist, do nothing.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_file_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			if l_file.exists then
				a_pixmap.set_with_named_file (a_file_name)
			end
		end

invariant
	all_constants_not_void: all_constants /= Void

end -- class CONSTANTS_IMP
