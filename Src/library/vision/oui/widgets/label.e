indexing

	description: "Simple label";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LABEL 

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end

creation

	make, make_unmanaged
	
feature {NONE} -- Creation 

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a label with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, True);
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a unmanaged label with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget (a_name, a_parent, False);
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a label with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.label (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

feature -- Resizing policies

	allow_recompute_size is
			-- Allow current label to recompute its size according to
			-- changes on its value.
		require
			exists: not destroyed
		do
			implementation.allow_recompute_size
		end;

	forbid_recompute_size is
			-- Forbid current label to recompute its size according to
			-- changes on its value.
		require
			exists: not destroyed
		do
			implementation.forbid_recompute_size
		end;

feature -- Text 
	
	set_center_alignment is
			-- Set text alignment of current label to center.
		require
			exists: not destroyed
		do
			implementation.set_center_alignment
		end;

	set_right_alignment is
			-- Set text alignment of current label to right.
		require
			exists: not destroyed
		do
			implementation.set_right_alignment
		end;
	
	set_left_alignment is
			-- Set text alignment of current label to left.
		require
			exists: not destroyed
		do
			implementation.set_left_alignment
		end;

	set_text (a_text: STRING) is
			-- Set text of current label to `a_text'.
		require
			exists: not destroyed;
			not_a_text_void: a_text /= Void
		do
			implementation.set_text (a_text);
		ensure
			text.is_equal (a_text)
		end;

	text: STRING is
			-- Text of current label
		require
			exists: not destroyed
		do
			Result:= implementation.text
		end 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: LABEL_I;
			-- Implementation of current label

feature {G_ANY, G_ANY_I, WIDGET_I}

	is_fontable: BOOLEAN is true;
			-- Is current widget an heir of FONTABLE ?
	
feature {NONE}

	set_default is
			-- Set default values to current label.
		do
		end;

end


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
