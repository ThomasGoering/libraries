indexing

	description: 
		"EiffelVision implementation of a motif primitive widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PRIMITIVE_M 

inherit

	WIDGET_M
		rename
			set_background_color as widget_set_background_color,
			update_background_color as widget_update_background_color
		end;

	WIDGET_M
		redefine
			set_background_color, update_background_color
		select
			set_background_color, update_background_color
		end;

	MEL_PRIMITIVE
		rename
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen
		end

feature -- Access

	is_stackable: BOOLEAN is 
			-- Is the Current widget stackable?
		do
			Result := True
		end;

feature -- Status Report

	foreground_color: COLOR is
			-- Color used for the foreground_color
		local
			fg_color_x: COLOR_X
		do
			if private_foreground_color = Void then
				!! private_foreground_color.make;
				fg_color_x ?= private_foreground_color.implementation;
				--fg_color_x.set_pixel (xt_pixel (screen_object, Mforeground_color));
			end;
			Result := private_foreground_color;
		end;

feature -- Status Setting

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		local
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if private_foreground_color /= Void then
				color_implementation ?= private_foreground_color.implementation;
				color_implementation.remove_object (Current)
			end;
			private_foreground_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			--ext_name := Mforeground_color.to_c;
			--c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
			--| Make sure to reset the foreground color
			--| if it has been set.
		local
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			widget_set_background_color (a_color);
			if private_foreground_color /= Void then
				update_foreground_color	
			end;	
		end;

feature {NONE} -- Implementation

	private_foreground_color: COLOR;
			-- Foreground_color colour

feature {COLOR_X}

	update_background_color is
			-- Update the background color after a change
			-- inside the Eiffel Color.
		do
			widget_update_background_color;
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end;

	update_foreground_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X
		do
			--ext_name := Mforeground_color.to_c;
			color_implementation ?= foreground_color.implementation;
			--c_set_color (screen_object, 
				--color_implementation.pixel (screen), $ext_name)
		end;

end -- class PRIMITIVE_M

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
