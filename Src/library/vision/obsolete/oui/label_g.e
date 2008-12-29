note

	description: "Simple label Gadget"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class LABEL_G 

obsolete
		"Use LABEL instead."
inherit

	LABEL
		undefine
			make, make_unmanaged, create_ev_widget
		redefine
			set_action, remove_action,
			background_color, set_background_color,
			background_pixmap, set_background_pixmap,
			foreground_color, set_foreground_color,
			implementation
		end

create

	make, make_unmanaged
	
feature {NONE} -- Creation 

	make (a_name: STRING; a_parent: COMPOSITE)
			-- Create a label gadget with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True)
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE)
			-- Create an unmanaged label gadget with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, False)
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a label gadget with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		local
			ot: OBSOLETE_TOOLKIT
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			ot ?= toolkit;
			check
				obsolete_toolkit_instantiated: ot /= Void
			end;
			implementation := ot.label_g (Current, man, a_parent);
			set_default
		end;


feature -- Callback (adding and removing) 

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY)
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		require else
			no_translation_on_gadgets: false
		do
		end;

	remove_action (a_translation: STRING)
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		require else
			no_translation_on_gadgets: false
		do
		end;

feature -- Color 

	background_color: COLOR
			-- Background color of widget
		do
		end; 

	foreground_color: COLOR
			-- Foreground color of primitive widget
		do
		end;

	set_background_color (new_color: COLOR)
			-- Set background color to `new_color'.
		require else
			Valid_new_color: new_color /= Void
		do
		end;

	set_foreground_color (new_color: COLOR)
			-- Set foreground color to `new_color'.
		require else
			Valid_new_color: new_color = Void
		do
		end 

feature -- Background pixmap 

	background_pixmap: PIXMAP
			-- Background pixmap of widget
		do
		end; 

	set_background_pixmap (new_pixmap: PIXMAP)
			-- Set background pixmap to `new_pixmap'.
		require else
			valid_new_pixmap: new_pixmap /= Void
		do
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: LABEL_G_I;;
			-- Implementation of current label gadget

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

