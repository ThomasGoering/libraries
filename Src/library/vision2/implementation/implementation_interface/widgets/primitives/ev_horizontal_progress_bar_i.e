indexing 
	description: "Eiffel Vision horizontal progress bar. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HORIZONTAL_PROGRESS_BAR_I

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface	
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_PROGRESS_BAR

end -- class EV_HORIZONTAL_PROGRESS_BAR_I

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
--| Revision 1.7  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.5  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.4.6.4  2000/01/31 21:31:34  brendel
--| Changed to comply with revised interface.
--|
--| Revision 1.4.6.3  2000/01/27 19:30:03  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.2  2000/01/10 18:42:55  rogers
--| Changed to fit in with the major Vision2 changes. set_default_options is no longer required. Added interface.
--|
--| Revision 1.4.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
