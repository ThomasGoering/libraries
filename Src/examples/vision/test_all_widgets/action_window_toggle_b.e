class ACTION_WINDOW_TOGGLE_B

inherit

	TOGGLE_B
		rename
			make as attach_to_widget
		end

create
	associate

feature

	association: ACTIONS_WINDOW

	associate (who: ACTIONS_WINDOW; number: INTEGER_REF; name: STRING; a_x, a_y: INTEGER) is
		do
			association := who
			attach_to_widget("exit", association)
			add_activate_action(association, number)
			set_text (clone (name))
			forbid_recompute_size
			set_size (130, 35)
			set_x_y (a_x, a_y)
		end

end -- class ACTION_WINDOW_TOGGLE_B

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

