indexing
	description	: "Constants for layout using Vision2"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_LAYOUT_CONSTANTS_IMP

feature -- Access (button size constants)

	Default_button_width: INTEGER is
			-- Default width for buttons
		do
			Result := default_label.width.max (74)
		end

	Default_button_height: INTEGER is
			-- Default height for buttons
		do
			Result := (default_label.height + small_padding_size).max (23)
		end

	default_label: EV_LABEL is
			-- Label used for querying default button dimensions
		once
			create Result.make_with_text ("WWWWW")
		end

feature -- Access (padding constants)

	Large_border_size: INTEGER is
			-- Default size for borders
		do
			Result := dialog_unit_to_pixels (10)
		end

	Default_padding_size: INTEGER is
			-- Default size for padding
		do
			Result := dialog_unit_to_pixels (14)
		end

	Small_padding_size: INTEGER is
			-- Small size for padding
		do
			Result := dialog_unit_to_pixels (10)
		end

	Tiny_padding_size: INTEGER is
			-- Tiny size for padding
		do
			Result := dialog_unit_to_pixels (3)
		end

feature -- Access (border constants)

	Default_border_size: INTEGER is
			-- Default size for borders
		do
			Result := dialog_unit_to_pixels (7)
		end

	Small_border_size: INTEGER is
			-- Small size for borders
		do
			Result := dialog_unit_to_pixels (5)
		end

feature -- Access

	resolution: INTEGER is
			-- Screen resolution.
		once
			Result := (create {EV_SCREEN}).horizontal_resolution
		end

feature -- Operation

	set_default_size_for_button (a_button: EV_BUTTON) is
			-- Set the default size for `a_button'.
		do
			a_button.set_minimum_size (
				a_button.minimum_width.max (Default_button_width),
				a_button.minimum_height.max (Default_button_height))
		end

feature -- Conversion

	dialog_unit_to_pixels (a_size: INTEGER): INTEGER is
			-- Convert `a_size' dialog units into pixels.
			-- Used to get the same look&feel under all platforms
		do
			Result := a_size
		end
		
end -- class EV_LAYOUT_CONSTANTS

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

