indexing
	description: "Eiffel Vision viewport. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_VIEWPORT_IMP
	
inherit
	EV_VIEWPORT_I
		redefine
			interface
		end
		
	EV_CELL_IMP
		redefine
			interface,
			make
		end
	
create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)
			set_c_object (C.gtk_viewport_new (NULL, NULL))
			viewport := c_object
		end	

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			Result := C.gtk_adjustment_struct_value (horizontal_adjustment).rounded
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			Result := C.gtk_adjustment_struct_value (vertical_adjustment).rounded
		end

feature -- Element change

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		do
			C.gtk_adjustment_set_value (horizontal_adjustment, a_x)
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			C.gtk_adjustment_set_value (vertical_adjustment, a_y)
		end

feature {NONE} -- Implementation

	horizontal_adjustment: POINTER is
		do
			Result := C.gtk_viewport_get_hadjustment (viewport)
		end

	vertical_adjustment: POINTER is
		do
			Result := C.gtk_viewport_get_vadjustment (viewport)
		end

	viewport: POINTER
			-- Pointer to viewport, used for reuse of adjustment functions from descendants.

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT

end -- class EV_VIEWPORT_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.3  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/02/12 00:25:06  king
--| Implemented view to new structure
--|
--| Revision 1.1.2.4  2000/02/11 19:00:29  oconnor
--| formatting
--|
--| Revision 1.1.2.3  2000/02/10 21:53:41  oconnor
--| started implementation
--|
--| Revision 1.1.2.2  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.1.2.1  2000/01/28 19:29:01  brendel
--| Initial. New ancestor for EV_SCROLLABLE_AREA.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
