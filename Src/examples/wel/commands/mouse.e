class
	SHOW_MOUSE_BUTTON_INFORMATION

inherit
	WEL_COMMAND

feature

	execute (argument: ANY) is
			-- Add information about Wm_lbuttondown message in the
			-- list box.
		local
			mi: WEL_MOUSE_MESSAGE
			lb: WEL_SINGLE_SELECTION_LIST_BOX
			s: STRING
		do
			mi ?= message_information
			lb ?= argument
			check
				mi_not_void: mi /= Void
				lb_not_void: lb /= Void
			end

			s := "WM_LBUTTONDOWN: x="
			s.append (mi.x.out)

			s.append (" y=")
			s.append (mi.y.out)

			s.append (" CTRL down=")
			s.append (mi.control_down.out)

			s.append (" SHIFT down=")
			s.append (mi.shift_down.out)

			lb.add_string (s)
			lb.select_item (lb.count - 1)
		end

end -- class SHOW_MOUSE_BUTTON_INFORMATION

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
