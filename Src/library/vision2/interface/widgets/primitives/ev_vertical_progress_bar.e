indexing 
	description:
		"Vertical bar graph gauge for displaying progress of a process."
	appearance:
		"+--+N%
		%|  |%N%
		%|  |%N%
		%|  |%N%
		%|25|%N%
		%|  |%N%
		%|##|%N%
		%|##|%N%
		%+--+"
	status: "See notice at end of class"
 	keywords: "status, progress, bar, vertical"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR

inherit
	EV_PROGRESS_BAR
		redefine
			implementation
		end

create
	default_create,
	make_with_value_range

feature {EV_ANY_I} -- Implementation

	implementation: EV_VERTICAL_PROGRESS_BAR_I
			-- Responsible for interaction with the native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VERTICAL_PROGRESS_BAR_IMP}
				implementation.make (Current)
		end

end -- class EV_VERTICAL_PROGRESS_BAR

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
