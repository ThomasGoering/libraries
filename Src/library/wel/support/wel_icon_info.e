indexing
	description	: "Information about an icon or a cursor."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_ICON_INFO

inherit
	WEL_STRUCTURE

create
	make

feature -- Status Report

	is_icon: BOOLEAN is
			-- Specifies whether this structure defines and icon or a cursor.
			-- True specifies an icon; False specifies a cursor.
		do
			Result := fIcon_ext (item)
		end
	
	x_hotspot: INTEGER is
			-- Specifies the x-coordinate of a cursor's hotspot.
			-- If this structure defines an icon, the hot spot is
			-- always in the center of the icon, and this member is ignored.
		do
			Result := xHotspot_ext (item)
		end
	
	y_hotspot: INTEGER is
			-- Specifies the y-coordinate of a cursor's hotspot.
			-- If this structure defines an icon, the hot spot is
			-- always in the center of the icon, and this member is ignored.
		do
			Result := yHotspot_ext (item)
		end
	
	mask_bitmap: WEL_BITMAP is
			-- bitmap representing the mask.
		do
			create Result.make_by_pointer(hbmMask_ext (item))
		end

	color_bitmap: WEL_BITMAP is
			-- bitmap representing the image (as opposed to the mask)
		do
			create Result.make_by_pointer(hbmColor_ext (item))
		end

feature -- Status Setting

	set_x_hotspot (xvalue: INTEGER) is
			-- Assign `xvalue' to xHotspot.
		do
			set_xHotspot_ext (item, xvalue)
		end

	set_y_hotspot (yvalue: INTEGER) is
			-- Assign `yvalue' to yHotspot.
		do
			set_yHotspot_ext (item, yvalue)
		end

	set_mask_bitmap (a_mask_bitmap: WEL_BITMAP) is
			-- Assign `a_mask_bitmap' to hbmMask
		do
			set_hbmMask_ext (item, a_mask_bitmap.item)
		end

	set_color_bitmap (a_color_bitmap: WEL_BITMAP) is
			-- Assign `a_color_bitmap' to hbmColor
		do
			set_hbmColor_ext (item, a_color_bitmap.item)
		end

	set_is_icon (a_is_icon: BOOLEAN) is
			-- Assign `a_is_icon' to fIcon.
		do
			set_fIcon_ext (item, a_is_icon)
		end

feature --  Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_iconinfo
		end


feature -- Obsolete

	fIcon: BOOLEAN is
		obsolete "use `is_icon' instead"
		do
			Result := is_icon
		end
	
	xHotspot: INTEGER is
		obsolete "use `x_hotspot' instead"
		do
			Result := x_hotspot
		end
	
	yHotspot: INTEGER is
		obsolete "use `y_hotspot' instead"
		do
			Result := y_hotspot
		end
	
	set_xHotspot (xvalue: INTEGER) is
		obsolete "use `set_x_hotspot' instead"
		do
			set_x_hotspot (xvalue)
		end

	set_yHotspot (yvalue: INTEGER) is
		obsolete "use `set_y_hotspot' instead"
		do
			set_y_hotspot (yvalue)
		end

	set_fIcon (a_is_icon: BOOLEAN) is
		obsolete "use `set_is_icon' instead"
		do
			set_is_icon (a_is_icon)
		end

feature {NONE} -- Externals

	c_size_of_iconinfo: INTEGER is
		external
			"C [macro <winuser.h>]"
		alias
			"sizeof (ICONINFO)"
		end
	
	fIcon_ext (p: POINTER): BOOLEAN is
			-- Access field fIcon of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_BOOLEAN"
		alias
			"fIcon"
		end

	xHotspot_ext (p: POINTER): INTEGER is
			-- Access field xHotspot of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_INTEGER"
		alias
			"xHotspot"
		end

	yHotspot_ext (p: POINTER): INTEGER is
			-- Access field yHotspot of struct pointed to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_INTEGER"
		alias
			"yHotspot"
		end

	hbmMask_ext (p: POINTER): POINTER is
			-- Access field hbmMask of stuct pointer to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_POINTER"
		alias
			"hbmMask"
		end

	hbmColor_ext (p: POINTER): POINTER is
			-- Access field hbmColor of stuct pointer to by `p'.
		external
			"C [struct %"winuser.h%"] (ICONINFO): EIF_POINTER"
		alias
			"hbmColor"
		end
	

	set_fIcon_ext (p: POINTER; value: BOOLEAN) is
			-- Set field fIcon of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, unsigned char)"
		alias
			"fIcon"
		end

	set_xHotspot_ext (p: POINTER; value: INTEGER) is
			-- Set field xHotspot of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, int)"
		alias
			"xHotspot"
		end

	set_yHotspot_ext (p: POINTER; value: INTEGER) is
			-- Set field yHotspot of struct pointed to by `p' to `value'.
		external
			"C [struct %"winuser.h%"] (ICONINFO, int)"
		alias
			"yHotspot"
		end

	set_hbmMask_ext (p, value: POINTER) is
			-- Set field hbmMask of struct pointed to by `p' to `value'
		external
			"C [struct %"winuser.h%"] (ICONINFO, HBITMAP)"
		alias
			"hbmMask"
		end

	set_hbmColor_ext (p, value: POINTER) is
			-- Set field hbmColor of struct pointed to by `p' to `value'
		external
			"C [struct %"winuser.h%"] (ICONINFO, HBITMAP)"
		alias
			"hbmColor"
		end

end -- class WEL_ICON_INFO
