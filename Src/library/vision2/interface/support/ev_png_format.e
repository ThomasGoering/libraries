indexing
	description:
		"Portable Network Graphics (PNG) Graphical Format Abstraction used by {EV_PIXMAP}.save_to_named_file"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PNG_FORMAT

inherit
	EV_GRAPHICAL_FORMAT

feature {EV_PIXMAP_I} -- Access

	file_extension: STRING is
			-- Three character file extension associated with format.
		once
			Result := "png"
		end

	save (raw_image_data: EV_RAW_IMAGE_DATA; a_filename: FILE_NAME) is
			-- Save `raw_image_data' to file `a_filename' in PNG format.
		do
			-- Implemented in pixmap implementation
		end

end -- class EV_PNG_FORMAT

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

