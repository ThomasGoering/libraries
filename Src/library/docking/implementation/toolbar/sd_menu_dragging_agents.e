indexing
	description: "Agents for SD_TOOL_BAR_ZONE dragging issues."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAGGING_AGENTS

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER; a_tool_bar_zone: SD_TOOL_BAR_ZONE) is
			-- Creation method.
		require
			not_void: a_docking_manager /= Void
			not_void: a_tool_bar_zone /= Void
		do
			default_create
			create internal_shared
			internal_docking_manager := a_docking_manager
			zone := a_tool_bar_zone

			init_actions
		ensure
			set: internal_docking_manager = a_docking_manager
			set: zone = a_tool_bar_zone
		end

	init_actions is
			-- Initialize actions.
		do
			zone.tool_bar.pointer_motion_actions.extend (agent on_pointer_motion)
			zone.tool_bar.pointer_button_release_actions.extend (agent on_pointer_release)
		end

feature -- Agents

	on_drag_area_pressed (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle drag area pressed.
		do
			if a_button = 1 and is_in_drag_area (a_screen_x, a_screen_y) then
				internal_pointer_pressed := True
				internal_docker_mediator := Void
				internal_shared.set_tool_bar_docker_mediator (Void)
			end
		ensure
			pointer_press_set: a_button = 1 and is_in_drag_area (a_screen_x, a_screen_y) implies internal_pointer_pressed = True
			docker_mediaot_void: a_button = 1 and is_in_drag_area (a_screen_x, a_screen_y) implies internal_docker_mediator = Void
		end

	on_drag_area_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle drag area release.
		do
			if a_button = 1 and is_in_drag_area (a_screen_x, a_screen_y) then
				internal_pointer_pressed := False
				internal_docker_mediator := Void
				internal_shared.set_tool_bar_docker_mediator (Void)
			end
		ensure
			pointer_press_set: a_button = 1 and is_in_drag_area (a_screen_x, a_screen_y) implies internal_pointer_pressed = False
			docker_mediaot_void: a_button = 1 and is_in_drag_area (a_screen_x, a_screen_y) implies internal_docker_mediator = Void
		end

	on_drag_area_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle drag area motion.
		local
			l_pixmaps: EV_STOCK_PIXMAPS
			l_offset_x, l_offset_y: INTEGER
		do
			create l_pixmaps
			if internal_docker_mediator = Void then
				if zone.drag_area_rectangle.has_x_y (a_x, a_y) then
					zone.tool_bar.set_pointer_style (l_pixmaps.sizeall_cursor)
				else
					zone.tool_bar.set_pointer_style (l_pixmaps.standard_cursor)
				end
			end
			if internal_pointer_pressed and (zone.drag_area_rectangle.has_x_y (a_x, a_y) or zone.is_floating) then
				if internal_docker_mediator = Void then
					zone.tool_bar.enable_capture
					zone.tool_bar.set_pointer_style (l_pixmaps.sizeall_cursor)

					create internal_docker_mediator.make (zone, internal_docking_manager)
					internal_docker_mediator.start_drag (a_screen_x, a_screen_y)

					if zone.is_floating then
						l_offset_x := a_screen_x - zone.floating_tool_bar.screen_x
						l_offset_y := a_screen_y - zone.floating_tool_bar.screen_y
					else
						l_offset_x := a_screen_x - zone.tool_bar.screen_x
						l_offset_y := a_screen_y - zone.tool_bar.screen_y
					end
					internal_docker_mediator.set_offset (zone.is_floating, l_offset_x, l_offset_y)
					internal_docker_mediator.cancel_actions.extend (agent on_cancel)
				end
			end
		ensure
			capture_enable: internal_pointer_pressed and (zone.drag_area_rectangle.has_x_y (a_x, a_y) or zone.is_floating)
				implies zone.tool_bar.has_capture and internal_docker_mediator /= Void
		end

	on_drag_area_pointer_double_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer double press actions.
		do
			if not zone.is_floating then
				if zone.drag_area_rectangle.has_x_y (a_x, a_y) then
					zone.assistant.floating_last_state
				end
			end
		end

feature -- Query

	is_in_drag_area (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If `a_screen_x' and `a_screen_y' in drag area?
		local
			l_in_docking_gripper_area, l_in_floating_tool_bar: BOOLEAN
		do
			l_in_docking_gripper_area := zone.drag_area_rectangle.has_x_y (a_screen_x - zone.tool_bar.screen_x, a_screen_y - zone.tool_bar.screen_y)
			if zone.is_floating then
				l_in_floating_tool_bar := zone.floating_tool_bar.internal_title_bar.drag_rectangle.has_x_y (a_screen_x, a_screen_y)
			end
			debug ("docking")
				print ("%N SD_TOOL_BAR_DRAGGING_AGENTS is_in_drag_area: l_in_docking_gripper_area " + l_in_docking_gripper_area.out + "; l_in_floating_tool_bar " + l_in_floating_tool_bar.out)
			end
			Result := l_in_docking_gripper_area or l_in_floating_tool_bar
		end

feature {NONE} -- Implementation functions

	on_cancel is
			-- Handle user cancel dragging events.
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			zone.tool_bar.disable_capture
			internal_pointer_pressed := False
			internal_docker_mediator := Void
			internal_shared.set_tool_bar_docker_mediator (Void)
			create l_pixmaps
			zone.tool_bar.set_pointer_style (l_pixmaps.standard_cursor)
		ensure
			disable_capture: not zone.tool_bar.has_capture
			not_pointer_pressed: not internal_pointer_pressed
			cleared: internal_shared.tool_bar_docker_mediator_cell.item = Void and internal_docker_mediator = Void
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion.
		do
			if internal_docker_mediator /= Void then
				internal_docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
			end
		ensure
			pointer_motion_forwarded:
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
			if internal_docker_mediator /= Void then
				internal_docker_mediator.apply_change (a_screen_x, a_screen_y)
				on_cancel
			end
		ensure
			disable_capture: not zone.tool_bar.has_capture
			not_pointer_pressed: internal_docker_mediator /= Void implies not internal_pointer_pressed
			cleared: internal_shared.tool_bar_docker_mediator_cell.item = Void
		end

feature {NONE} -- Implementation attributes

	internal_shared: SD_SHARED
			-- All singletons.

	zone: SD_TOOL_BAR_ZONE
			-- Tool bar zone current belong to.		

	internal_docker_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR
			-- Docker mediator.

	internal_pointer_pressed: BOOLEAN
			-- If pointer pressed?

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager Current belong to.

invariant
	not_void: internal_shared /= Void
	not_void: zone /= Void
	not_void: internal_docking_manager /= Void

end
