note
	description: "[
		Objects that represent an EV_TITLED_WINDOW.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TRANSFORM_PANEL_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end

	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants

				-- Build widget structure.
			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (apply_button)
			l_ev_horizontal_box_1.extend (refresh_button)
			extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (type_editor_radio_button)
			l_ev_horizontal_box_2.extend (type_tool_radio_button)
			l_ev_horizontal_box_2.extend (type_place_holder_radio_button)
			extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (top_radio_button)
			l_ev_vertical_box_1.extend (tab_with_radio_button)
			l_ev_vertical_box_1.extend (relative_radio_button)
			l_ev_vertical_box_1.extend (auto_hide_radio_button)
			l_ev_vertical_box_1.extend (float_radio_button)
			l_ev_vertical_box_1.extend (default_editor_radio_button)
			l_ev_horizontal_box_3.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (direction_frame)
			direction_frame.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (up_radio_button)
			l_ev_horizontal_box_4.extend (down_radio_button)
			l_ev_horizontal_box_4.extend (left_radio_button)
			l_ev_horizontal_box_4.extend (right_radio_button)
			l_ev_vertical_box_2.extend (screen_position_frame)
			screen_position_frame.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_label_1)
			l_ev_horizontal_box_5.extend (screen_x_button)
			l_ev_horizontal_box_5.extend (l_ev_cell_1)
			l_ev_horizontal_box_5.extend (l_ev_label_2)
			l_ev_horizontal_box_5.extend (screen_y_button)
			l_ev_vertical_box_2.extend (existing_contents_frame)
			existing_contents_frame.extend (existing_contents_list)

			l_ev_horizontal_box_1.disable_item_expand (apply_button)
			l_ev_horizontal_box_1.disable_item_expand (refresh_button)
			apply_button.set_text ("Apply Changes")
			refresh_button.set_text ("Refresh")
			l_ev_frame_1.set_text ("Type")
			l_ev_horizontal_box_2.disable_item_expand (type_editor_radio_button)
			l_ev_horizontal_box_2.disable_item_expand (type_tool_radio_button)
			l_ev_horizontal_box_2.disable_item_expand (type_place_holder_radio_button)
			type_editor_radio_button.set_text ("Editor")
			type_tool_radio_button.set_text ("Tool")
			type_place_holder_radio_button.set_text ("Place Holder")
			l_ev_frame_2.set_text ("Posit")
			l_ev_horizontal_box_3.disable_item_expand (l_ev_vertical_box_1)
			l_ev_vertical_box_1.disable_item_expand (top_radio_button)
			l_ev_vertical_box_1.disable_item_expand (tab_with_radio_button)
			l_ev_vertical_box_1.disable_item_expand (relative_radio_button)
			l_ev_vertical_box_1.disable_item_expand (auto_hide_radio_button)
			l_ev_vertical_box_1.disable_item_expand (float_radio_button)
			l_ev_vertical_box_1.disable_item_expand (default_editor_radio_button)
			top_radio_button.set_text ("Top")
			top_radio_button.set_tooltip ("Posit content to top level of the window.")
			tab_with_radio_button.set_text ("Tab With")
			tab_with_radio_button.set_tooltip ("Set content tabbed with selected content.")
			relative_radio_button.set_text ("Relative")
			relative_radio_button.set_tooltip ("Set content to which side of selected content.")
			auto_hide_radio_button.set_text ("Auto Hide")
			auto_hide_radio_button.set_tooltip ("Set content auto hide mode.")
			float_radio_button.set_text ("Float")
			float_radio_button.set_tooltip ("Set content floating.")
			default_editor_radio_button.set_text ("Default Editor")
			default_editor_radio_button.set_tooltip ("Set default editor position.")
			l_ev_vertical_box_2.disable_item_expand (direction_frame)
			l_ev_vertical_box_2.disable_item_expand (screen_position_frame)
			direction_frame.set_text ("Direction")
			l_ev_horizontal_box_4.disable_item_expand (up_radio_button)
			l_ev_horizontal_box_4.disable_item_expand (down_radio_button)
			l_ev_horizontal_box_4.disable_item_expand (left_radio_button)
			l_ev_horizontal_box_4.disable_item_expand (right_radio_button)
			up_radio_button.set_text ("Up")
			down_radio_button.set_text ("Down")
			left_radio_button.set_text ("Left")
			right_radio_button.set_text ("Right")
			screen_position_frame.set_text ("Screen Position")
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_1)
			l_ev_horizontal_box_5.disable_item_expand (screen_x_button)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_cell_1)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_2)
			l_ev_horizontal_box_5.disable_item_expand (screen_y_button)
			l_ev_label_1.set_text ("X: ")
			screen_x_button.set_minimum_width (80)
			l_ev_cell_1.set_minimum_width (5)
			l_ev_label_2.set_text ("Y: ")
			screen_y_button.set_minimum_width (80)
			existing_contents_frame.set_text ("Existing Contents")
			disable_item_expand (l_ev_horizontal_box_1)
			disable_item_expand (l_ev_frame_1)

			set_all_attributes_using_constants

				-- Connect events.
			apply_button.select_actions.extend (agent on_apply)
			refresh_button.select_actions.extend (agent refresh)
			type_editor_radio_button.select_actions.extend (agent type_editor_radio_button_selected)
			type_tool_radio_button.select_actions.extend (agent type_tool_radio_button_selected)
			type_place_holder_radio_button.select_actions.extend (agent type_place_holder_radio_button_selected)
			top_radio_button.select_actions.extend (agent on_top_radio_button_selected)
			tab_with_radio_button.select_actions.extend (agent on_tab_with_radio_button_selected)
			relative_radio_button.select_actions.extend (agent on_relative_radio_button_selected)
			auto_hide_radio_button.select_actions.extend (agent on_auto_hide_radio_button_selected)
			float_radio_button.select_actions.extend (agent on_float_radio_button_selected)
			default_editor_radio_button.select_actions.extend (agent on_default_editor_button_selected)

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	screen_x_button, screen_y_button: EV_SPIN_BUTTON
	existing_contents_list: EV_LIST
	apply_button, refresh_button: EV_BUTTON
	type_editor_radio_button,
	type_tool_radio_button, type_place_holder_radio_button, top_radio_button, tab_with_radio_button,
	relative_radio_button, auto_hide_radio_button, float_radio_button, default_editor_radio_button,
	up_radio_button, down_radio_button, left_radio_button, right_radio_button: EV_RADIO_BUTTON
	direction_frame,
	screen_position_frame, existing_contents_frame: EV_FRAME

feature {NONE} -- Implementation

	l_ev_cell_1: EV_CELL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3,
	l_ev_horizontal_box_4, l_ev_horizontal_box_5: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1, l_ev_vertical_box_2: EV_VERTICAL_BOX
	l_ev_label_1,
	l_ev_label_2: EV_LABEL
	l_ev_frame_1, l_ev_frame_2: EV_FRAME

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

	on_apply
			-- Called by `select_actions' of `apply_button'.
		deferred
		end

	refresh
			-- Called by `select_actions' of `refresh_button'.
		deferred
		end

	type_editor_radio_button_selected
			-- Called by `select_actions' of `type_editor_radio_button'.
		deferred
		end

	type_tool_radio_button_selected
			-- Called by `select_actions' of `type_tool_radio_button'.
		deferred
		end

	type_place_holder_radio_button_selected
			-- Called by `select_actions' of `type_place_holder_radio_button'.
		deferred
		end

	on_top_radio_button_selected
			-- Called by `select_actions' of `top_radio_button'.
		deferred
		end

	on_tab_with_radio_button_selected
			-- Called by `select_actions' of `tab_with_radio_button'.
		deferred
		end

	on_relative_radio_button_selected
			-- Called by `select_actions' of `relative_radio_button'.
		deferred
		end

	on_auto_hide_radio_button_selected
			-- Called by `select_actions' of `auto_hide_radio_button'.
		deferred
		end

	on_float_radio_button_selected
			-- Called by `select_actions' of `float_radio_button'.
		deferred
		end

	on_default_editor_button_selected
			-- Called by `select_actions' of `default_editor_radio_button'.
		deferred
		end


feature {NONE} -- Constant setting

	set_attributes_using_string_constants
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: detachable STRING_GENERAL
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				check s /= Void end -- Implied by design of EiffelBuild
				string_constant_set_procedures.item.call ([s])
				string_constant_set_procedures.forth
			end
		end

	set_attributes_using_integer_constants
			-- Set all attributes relying on integer constants to the current
			-- value of the associated constant.
		local
			i: INTEGER
			arg1, arg2: INTEGER
			int: INTEGER_INTERVAL
		do
			from
				integer_constant_set_procedures.start
			until
				integer_constant_set_procedures.off
			loop
				integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).call (Void)
				i := integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).last_result
				integer_constant_set_procedures.item.call ([i])
				integer_constant_set_procedures.forth
			end
			from
				integer_interval_constant_retrieval_functions.start
				integer_interval_constant_set_procedures.start
			until
				integer_interval_constant_retrieval_functions.off
			loop
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg1 := integer_interval_constant_retrieval_functions.item.last_result
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg2 := integer_interval_constant_retrieval_functions.item.last_result
				create int.make (arg1, arg2)
				integer_interval_constant_set_procedures.item.call ([int])
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_set_procedures.forth
			end
		end

	set_attributes_using_pixmap_constants
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: detachable EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				check p /= Void end -- Implied by design of EiffelBuild
				pixmap_constant_set_procedures.item.call ([p])
				pixmap_constant_set_procedures.forth
			end
		end

	set_attributes_using_font_constants
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: detachable EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				check f /= Void end -- Implied by design of EiffelBuild
				font_constant_set_procedures.item.call ([f])
				font_constant_set_procedures.forth
			end
		end

	set_attributes_using_color_constants
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: detachable EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				check c /= Void end -- Implied by design of EiffelBuild
				color_constant_set_procedures.item.call ([c])
				color_constant_set_procedures.forth
			end
		end

	set_all_attributes_using_constants
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end

	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [STRING_GENERAL]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING_GENERAL]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER]]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_PIXMAP]]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER_INTERVAL]]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_FONT]]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_COLOR]]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_COLOR]]

	integer_from_integer (an_integer: INTEGER): INTEGER
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
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

end
