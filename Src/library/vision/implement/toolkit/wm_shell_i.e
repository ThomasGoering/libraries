indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class WM_SHELL_I 

feature 

	set_base_height (a_height: INTEGER) is
			-- Set `base_height' to `a_height'. 
		require
			height_large_enough: a_height >= 0
		deferred
		ensure
			base_height = a_height
		end; -- set_base_height

 	base_height: INTEGER is
			-- Base for a progression of preferred heights
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred heights are `base_heights' plus
			-- integral multiples of `height_inc'
		deferred
		ensure
			Result >= 0
		end; -- base_height

	set_base_width (a_width: INTEGER) is
			-- Set `base_width' to `a_width'.
		require
			width_large_enough: a_width >= 0
		deferred
		ensure
			base_width = a_width
		end; -- set_base_width

	base_width: INTEGER is
			-- Base for a progression of preferred widths
			-- for current window manager to use in sizing
			-- widgets.
			-- The preferred widths are `base_heights' plus
			-- integral multiples of `width_inc'
		deferred
		ensure
			Result >= 0
		end; -- base_width

	set_height_inc (an_increment: INTEGER) is
			-- Set `height_inc' to `an_increment'.
		require
			an_increment_large_enought: an_increment >= 0
		deferred
		ensure
			height_inc = an_increment
		end; -- set_height_inc

	height_inc: INTEGER is
			-- Increment for a progression of preferred
			-- heights for the window manager tu use in sizing 
			-- widgets.
		deferred
		ensure
			Result >= 0
		end; -- height_inc

	set_width_inc (an_increment: INTEGER) is
			-- Set `width_inc' to `an_increment'.
		require
			an_increment_large_enough: an_increment >= 0
		deferred
		ensure
			width_inc = an_increment
		end; -- set_width_inc

	width_inc: INTEGER is
			-- Increment for a progression of preferred
			-- widths for the window manager tu use in sizing
			-- widgets.
		deferred
		ensure
			Result >= 0
		end; -- width_inc

	set_icon_mask (a_mask: PIXMAP) is
			-- Set `icon_mask' to `a_mask'.
		require
			not_a_mask_void: not (a_mask = Void)
		deferred
		end; -- set_icon_mask

	icon_mask: PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		deferred
		end; -- icon_mask

	set_icon_pixmap (a_pixmap: PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		require
			not_a_pixmap_void: not (a_pixmap = Void)
		deferred
		end; -- set_icon_pixmap

	icon_pixmap: PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		deferred
		end; -- icon_pixmap

	set_icon_x (x_value: INTEGER) is
			-- Set `icon_x' to `x_value'.
		deferred
		end; -- set_icon_x

	icon_x: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		deferred
		end; -- icon_x

	set_icon_y (y_value: INTEGER) is
			-- Set `icon_y' to `y_value'.
		deferred
		end; -- set_icon_y

	icon_y: INTEGER is
			-- Place to put application's icon
			-- Since the window manager controls icon placement
			-- policy, this may be ignored.
		deferred
		end; -- icon_y

	set_max_aspect_x (a_max: INTEGER) is
			-- Set `max_aspect_x' to `a_max'.
		deferred
		ensure
			max_aspect_x = a_max
		end; -- set_max_aspect_x

	max_aspect_x: INTEGER is
			-- Numerator of maximum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		deferred
		end; -- max_aspect_x

	set_max_aspect_y (a_max: INTEGER) is
			-- Set `max_aspect_y' to `a_max'.
		deferred
		ensure
			max_aspect_y = a_max
		end; -- set_max_aspect_y

	max_aspect_y: INTEGER is
			-- Denominator of maximum ration (X/Y) that
			-- application wishes widget instance to have
		deferred
		end; -- max_aspect_y

	set_max_height (a_height: INTEGER) is
			-- Set `max_height' to `a_height'.
		require
			a_height_large_enough: a_height >= 1
		deferred
		ensure
			max_height = a_height
		end; -- set_max_height

	max_height: INTEGER is
			-- Maximum height that application wishes widget
			-- instance to have
		deferred
		ensure
			Result >= 1
		end; -- max_height

	set_max_width (a_max: INTEGER) is
			-- Set `max_width' to `a_max'.
		require
			a_max_large_enough: a_max >= 1
		deferred
		ensure
			max_width = a_max
		end; -- set_max_width

	max_width: INTEGER is
			-- Maximum width that application wishes widget
			-- instance to have
		deferred
		ensure
			Result >= 1
		end; -- max_width

	set_min_aspect_x (a_min: INTEGER) is
			-- Set `min_aspect_x' to `a_min'.
		deferred
		ensure
			min_aspect_x = a_min
		end; -- set_min_aspect_x

	min_aspect_x: INTEGER is
			-- Numerator of minimum aspect ratio (X/Y) that
			-- application wishes widget instance to have
		deferred
		end; -- min_aspect_x

	set_min_aspect_y (a_min: INTEGER) is
			-- Set `min_aspect_y' to `a_min'.
		deferred
		ensure
			min_aspect_y = a_min
		end; -- set_min_aspect_y

	min_aspect_y: INTEGER is
			-- Denominator of minimum ration (X/Y) that
			-- application wishes widget instance to have
		deferred
		end; -- min_aspect_y

	set_min_height (a_height: INTEGER) is
			-- Set `min_height' to `a_height'.
		require
			a_height_large_enough: a_height >= 1
		deferred
		ensure
			min_height = a_height
		end; -- set_min_height

	min_height: INTEGER is
			-- minimum height that application wishes widget
			-- instance to have
		deferred
		ensure
			Result >= 1
		end; -- min_height

	set_min_width (a_min: INTEGER) is
			-- Set `min_width' to `a_min'.
		require
			a_min_large_enough: a_min >= 1
		deferred
		ensure
			min_width = a_min
		end; -- set_min_width

	min_width: INTEGER is
			-- minimum width that application wishes widget
			-- instance to have
		deferred
		ensure
			Result >= 1
		end; -- min_width

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		require
			not_a_title_void: not (a_title = Void)
		deferred
		end; -- set_title

	title: STRING is
			-- Application name to be displayed by
			-- the window manager
		deferred
		end; -- title

	set_widget_group (a_widget: WIDGET) is
			-- Set `widget_group' to `a_widget'.
		deferred
		end; -- set_widget_group

	widget_group: WIDGET is
			-- Widget with wich current widget is associated.
			-- By convention this widget is the "leader" of a group
			-- widgets. Window manager will treat all widgets in
			-- a group in some way; for example, it may move or
			-- iconify them together
		deferred
		end -- widget_group

end -- class WM_SHELL_I


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
