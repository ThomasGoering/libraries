note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	POSITION_TAB_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_frame_1
			create drawable
			create l_ev_table_1
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create virtual_x_position
			create l_ev_horizontal_box_2
			create l_ev_label_2
			create virtual_y_position
			create l_ev_horizontal_box_3
			create first_visible_column_label
			create l_ev_horizontal_box_4
			create first_visible_row_label
			create l_ev_horizontal_box_5
			create last_visible_column_label
			create l_ev_horizontal_box_6
			create last_visible_row_label
			create viewable_width
			create viewable_height
			create viewable_x_offset
			create viewable_y_offset
			
				-- Build_widget_structure.
			extend (l_ev_frame_1)
			l_ev_frame_1.extend (drawable)
			extend (l_ev_table_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (virtual_x_position)
			l_ev_horizontal_box_2.extend (l_ev_label_2)
			l_ev_horizontal_box_2.extend (virtual_y_position)
			l_ev_horizontal_box_3.extend (first_visible_column_label)
			l_ev_horizontal_box_4.extend (first_visible_row_label)
			l_ev_horizontal_box_5.extend (last_visible_column_label)
			l_ev_horizontal_box_6.extend (last_visible_row_label)
			
			l_ev_table_1.resize (2, 5)
			l_ev_table_1.set_row_spacing (box_padding)
			l_ev_table_1.set_column_spacing (box_padding)
				-- Insert and position all children of `l_ev_table_1'.
			l_ev_table_1.put_at_position (l_ev_horizontal_box_1, 1, 1, 1, 1)
			l_ev_table_1.put_at_position (l_ev_horizontal_box_2, 2, 1, 1, 1)
			l_ev_table_1.put_at_position (l_ev_horizontal_box_3, 1, 2, 1, 1)
			l_ev_table_1.put_at_position (l_ev_horizontal_box_4, 2, 2, 1, 1)
			l_ev_table_1.put_at_position (l_ev_horizontal_box_5, 1, 3, 1, 1)
			l_ev_table_1.put_at_position (l_ev_horizontal_box_6, 2, 3, 1, 1)
			l_ev_table_1.put_at_position (viewable_width, 1, 4, 1, 1)
			l_ev_table_1.put_at_position (viewable_height, 2, 4, 1, 1)
			l_ev_table_1.put_at_position (viewable_x_offset, 1, 5, 1, 1)
			l_ev_table_1.put_at_position (viewable_y_offset, 2, 5, 1, 1)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_label_1.set_text ("Virtual X : ")
			virtual_x_position.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1000000))
			l_ev_horizontal_box_2.set_padding_width (box_padding)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("Virtual Y : ")
			virtual_y_position.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1000000))
			set_padding_width (box_padding)
			set_border_width (box_padding)
			disable_item_expand (l_ev_table_1)
			
				--Connect events.
			drawable.expose_actions.extend (agent drawable_exposed (?, ?, ?, ?))
			drawable.pointer_motion_actions.extend (agent pointed_moved_on_drawable (?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_button_press_actions.extend (agent button_pressed_on_drawable (?, ?, ?, ?, ?, ?, ?, ?))
			drawable.pointer_button_release_actions.extend (agent button_released_on_drawable (?, ?, ?, ?, ?, ?, ?, ?))
			drawable.resize_actions.extend (agent drawable_resized (?, ?, ?, ?))
			virtual_x_position.change_actions.extend (agent virtual_x_position_changed (?))
			virtual_y_position.change_actions.extend (agent virtual_y_position_changed (?))
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	virtual_x_position, virtual_y_position: EV_SPIN_BUTTON
	drawable: EV_DRAWING_AREA
	first_visible_column_label, first_visible_row_label,
	last_visible_column_label, last_visible_row_label, viewable_width, viewable_height,
	viewable_x_offset, viewable_y_offset: EV_LABEL

feature {NONE} -- Implementation

	l_ev_table_1: EV_TABLE
	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3,
	l_ev_horizontal_box_4, l_ev_horizontal_box_5, l_ev_horizontal_box_6: EV_HORIZONTAL_BOX
	l_ev_label_1,
	l_ev_label_2: EV_LABEL
	l_ev_frame_1: EV_FRAME

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	drawable_exposed (a_x, a_y, a_width, a_height: INTEGER)
			-- Called by `expose_actions' of `drawable'.
		deferred
		end
	
	pointed_moved_on_drawable (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Called by `pointer_motion_actions' of `drawable'.
		deferred
		end
	
	button_pressed_on_drawable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Called by `pointer_button_press_actions' of `drawable'.
		deferred
		end
	
	button_released_on_drawable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Called by `pointer_button_release_actions' of `drawable'.
		deferred
		end
	
	drawable_resized (a_x, a_y, a_width, a_height: INTEGER)
			-- Called by `resize_actions' of `drawable'.
		deferred
		end
	
	virtual_x_position_changed (a_value: INTEGER)
			-- Called by `change_actions' of `virtual_x_position'.
		deferred
		end
	
	virtual_y_position_changed (a_value: INTEGER)
			-- Called by `change_actions' of `virtual_y_position'.
		deferred
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


end -- class POSITION_TAB_IMP
