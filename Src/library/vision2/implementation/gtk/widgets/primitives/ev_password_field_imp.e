indexing
	description: "iffelVision password field, gtk implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD_IMP

inherit
	EV_PASSWORD_FIELD_I

	EV_TEXT_FIELD_IMP
		redefine
			make,
			make_with_text
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create an empty password field
		do
			{EV_TEXT_FIELD_IMP} Precursor
			gtk_entry_set_visibility (widget, False)
		end

	make_with_text (txt: STRING) is
			-- Create a password field with `txt' as
			-- label.
		do
			{EV_TEXT_FIELD_IMP} Precursor (txt)
			gtk_entry_set_visibility (widget, False)		
		end

feature -- Access

	character: CHARACTER is
			-- Displayed character instead of the text.
		do
		end

feature -- Element change

	set_character (char: CHARACTER) is
			-- Make `char' the new character displayed in the
			-- password field.
		do
		end

end -- class EV_PASSWORD_FIELD_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
