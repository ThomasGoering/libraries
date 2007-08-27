indexing
	description: "Pixel buffer that replaces orignal image file.%
		%The orignal version of this class has been generated by Image Eiffel Code."
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	SD_UP_LIGHT_ICON

inherit
	EV_PIXEL_BUFFER

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			make_with_size (41, 35)
			fill_memory
		end

feature {NONE} -- Image data

	c_colors_0 (a_ptr: POINTER; a_offset: INTEGER) is
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(00,00,00,00)A(0B,75,83,C1)A(74,80,8F,D2)A(D9,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(E8,80,8F,D3)A(F3,81,90,D4)A(F7,81,90,D4)A(FA,81,90,D4)A(FC,81,90,D4)A(FD,81,90,D4)A(FD,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(DA,80,8F,D3)A(76,7E,8D,CF)A(0E,5C,67,97)A(03,00,00,00)A(02,00,00,00)A(01,00,00,00)A(01,00,00,00)A(0B,75,83,C1)A(97,80,8F,D2)A(FF,8C,95,BE)A(FF,96,9A,AA)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,98,9B,A8)A(FF,99,9B,A5)A(FF,99,9C,A5)A(FF,9A,9C,A4)A(FF,9A,9C,A4)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,9A,9C,A3)A(FF,96,9A,AA)A(FF,8C,95,BE)A(9B,7D,8B,CD)A(14,41,48,6A)A(07,00,00,00)
				A(04,00,00,00)A(02,00,00,00)A(74,80,8F,D2)A(FF,8C,95,BE)A(FF,9C,9E,A5)A(FF,A1,A3,AB)A(FF,A7,AA,B1)A(FF,AA,AC,B4)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AA,AC,B6)A(FF,AA,AC,B4)A(FF,AA,AC,B4)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AB,AD,B5)A(FF,AA,AC,B4)A(FF,A7,AA,B1)A(FF,8F,99,C2)A(7F,75,82,C0)A(0F,00,00,00)A(09,00,00,00)A(05,00,00,00)A(DA,80,8F,D3)A(FF,98,9C,AC)A(FF,A6,A9,B0)A(FF,B8,BA,C3)A(FF,C6,C8,D1)A(FF,CB,CE,D7)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CB,CE,D8)A(FF,CA,CD,D6)A(FF,CB,CE,D7)A(FF,CB,CE,D7)A(FF,CC,CE,D8)A(FF,CC,CE,D8)A(FF,CC,CE,D8)A(FF,CC,CE,D8)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CD,CF,D9)A(FF,CB,CE,D7)A(FF,C6,C8,D1)A(FF,B0,B4,C6)
				A(DF,7D,8C,CE)A(1B,00,00,00)A(11,00,00,00)A(09,00,00,00)A(FF,81,90,D4)A(FF,A1,A3,AB)A(FF,B8,BA,C3)A(FF,CE,D1,DA)A(FF,DA,DC,E6)A(FF,DC,DF,E9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DC,DF,E9)A(FF,DB,DE,E8)A(FF,DB,DE,E8)A(FF,DC,DF,E9)A(FF,DC,DF,E9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DC,DF,E9)A(FF,DA,DC,E6)A(FF,CE,D1,DA)A(FF,81,90,D4)A(2B,00,00,00)A(1B,00,00,00)A(0F,00,00,00)A(FF,81,90,D4)A(FF,A7,AA,B1)A(FF,C6,C8,D1)A(FF,DA,DC,E6)A(FF,DD,E0,EA)A(FF,BF,C6,E1)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,BF,C6,E1)A(FF,DB,DE,E8)A(FF,DC,DF,E9)
				A(FF,DD,E0,EA)A(FF,DA,DC,E6)A(FF,81,90,D4)A(3A,00,00,00)A(25,00,00,00)A(15,00,00,00)A(FF,81,90,D4)A(FF,AA,AC,B4)A(FF,CB,CE,D7)A(FF,DC,DF,E9)A(FF,DC,DF,E9)A(FF,AB,B5,DC)A(FF,CF,D9,FC)A(FF,CF,DA,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,CF,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,CF,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,D0,D9,FC)A(FF,AB,B5,DC)A(FF,D9,DC,E5)A(FF,DB,DE,E8)A(FF,DC,DF,E9)A(FF,DC,DF,E9)A(FF,81,90,D4)A(47,00,00,00)A(2F,00,00,00)A(1B,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DB,DE,E8)A(FF,AB,B5,DC)A(FF,A0,B0,ED)A(FF,A0,B0,ED)A(FF,A0,AF,ED)A(FF,A0,B1,ED)A(FF,A0,B0,ED)A(FF,9F,AF,EC)A(FF,9F,B0,ED)A(FF,A0,AF,ED)A(FF,A0,B0,ED)A(FF,A0,B1,ED)A(FF,9F,B0,ED)A(FF,A0,B0,ED)A(FF,9F,B1,ED)A(FF,A0,AF,ED)A(FF,9F,B0,ED)A(FF,A0,AF,ED)A(FF,9F,AF,ED)A(FF,A0,B0,EC)A(FF,9F,AF,ED)A(FF,9F,B0,ED)A(FF,A0,B0,ED)A(FF,9F,B0,ED)A(FF,A0,B0,ED)A(FF,9F,B1,EC)A(FF,A0,AF,ED)A(FF,A1,B1,EE)A(FF,AB,B5,DC)
				A(FF,D4,D7,E1)A(FF,D9,DC,E5)A(FF,DB,DE,E8)A(FF,DD,E0,EA)A(FF,81,90,D4)A(52,00,00,00)A(35,00,00,00)A(20,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DB,DE,E8)A(FF,AB,B5,DC)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,71,85,D2)A(FF,71,86,D2)A(FF,71,85,D2)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,85,D2)A(FF,72,85,D2)A(FF,72,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,71,85,D2)A(FF,71,86,D2)A(FF,71,86,D2)A(FF,72,86,D2)A(FF,72,87,D2)A(FF,AB,B5,DC)A(FF,D0,D3,DC)A(FF,D7,DA,E4)A(FF,DB,DE,E8)A(FF,DD,E0,EA)A(FF,81,90,D4)A(58,00,00,00)A(3A,00,00,00)A(23,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,AE,BA,EA)A(FF,AE,B9,EA)A(FF,AF,B9,EA)A(FF,AE,B9,EA)A(FF,AE,B9,EA)A(FF,AE,B9,EA)A(FF,AE,B9,EA)A(FF,AF,B9,EA)A(FF,AF,B9,EA)A(FF,AF,B9,EA)A(FF,AF,B9,EA)A(FF,AE,B9,EA)A(FF,AE,B9,EA)A(FF,AE,B9,EA)A(FF,AE,B9,EA)A(FF,AE,B9,EA)A(FF,AF,B9,EA)A(FF,AE,B9,EA)A(FF,AF,B9,EA)A(FF,AE,B9,EA)A(FF,AE,BA,EA)A(FF,AE,BA,EA)A(FF,AE,B9,EA)A(FF,AE,B9,EA)A(FF,AF,BA,EA);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_1 (a_ptr: POINTER; a_offset: INTEGER) is
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,AE,BA,EA)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D6,D9,E3)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5B,00,00,00)A(3D,00,00,00)A(24,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,B7,C1,ED)A(FF,B7,C1,EC)A(FF,B7,C1,ED)A(FF,B7,C0,EC)A(FF,B7,C1,EC)A(FF,B7,C1,ED)A(FF,B7,C0,ED)A(FF,B6,C1,ED)A(FF,B7,C0,ED)A(FF,B7,C0,ED)A(FF,B7,C0,ED)A(FF,B7,C1,EC)A(FF,B6,C1,ED)A(FF,B7,C1,EC)A(FF,B6,C1,ED)A(FF,B6,C1,ED)A(FF,B6,C1,ED)A(FF,B6,C1,ED)A(FF,B6,C1,ED)A(FF,B7,C1,ED)A(FF,B7,C0,ED)A(FF,B7,C1,EC)A(FF,B7,C1,EC)A(FF,B7,C1,EC)A(FF,B7,C0,ED)A(FF,B7,C0,EC)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,C3,CB,F0)A(FF,C3,CC,F1)A(FF,C3,CB,F0)A(FF,C3,CC,F1)A(FF,C3,CC,F0)A(FF,C3,CC,F0)A(FF,C3,CC,F0)A(FF,C3,CB,F0)A(FF,C3,CC,F1)A(FF,C3,CC,F0)A(FF,C3,CB,F1)A(FF,C3,CC,F1)A(FF,C2,CC,F0)A(FF,C3,CC,F0)A(FF,C3,CB,F1)A(FF,C3,CB,F0)A(FF,C3,CB,F1)A(FF,C3,CB,F1)A(FF,C3,CC,F0)A(FF,C3,CC,F0)A(FF,C3,CC,F0)A(FF,C3,CC,F1)A(FF,C3,CC,F0)
				A(FF,C3,CC,F0)A(FF,C3,CC,F0)A(FF,C2,CB,F0)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,D0,D8,F5)A(FF,D1,D8,F5)A(FF,D1,D8,F4)A(FF,D1,D7,F5)A(FF,D1,D7,F5)A(FF,D1,D8,F4)A(FF,D0,D8,F4)A(FF,D0,D7,F4)A(FF,D1,D7,F4)A(FF,D0,D7,F5)A(FF,D1,D8,F5)A(FF,D1,D8,F5)A(FF,D0,D8,F5)A(FF,D1,D8,F4)A(FF,D0,D8,F5)A(FF,D0,D8,F4)A(FF,D1,D8,F5)A(FF,D0,D8,F4)A(FF,D0,D8,F5)A(FF,D0,D8,F5)A(FF,D0,D8,F5)A(FF,D0,D8,F5)A(FF,D1,D8,F5)A(FF,D1,D8,F5)A(FF,D1,D8,F5)A(FF,D0,D8,F4)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,DD,E2,F9)A(FF,DD,E3,F8)A(FF,DD,E3,F9)A(FF,DD,E2,F8)A(FF,DD,E3,F8)A(FF,DD,E3,F9)A(FF,DD,E2,F9)A(FF,DD,E3,F8)A(FF,DD,E2,F8)A(FF,DD,E3,F9)A(FF,DD,E3,F9)A(FF,DD,E2,F9)A(FF,DD,E3,F8)A(FF,DC,E3,F8)A(FF,DD,E2,F8)A(FF,DD,E3,F8)A(FF,DD,E3,F8)A(FF,DD,E3,F8)A(FF,DD,E3,F9)A(FF,DD,E2,F9)A(FF,DD,E2,F8)
				A(FF,DD,E2,F9)A(FF,DD,E3,F8)A(FF,DD,E2,F8)A(FF,DD,E3,F9)A(FF,DD,E3,F8)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,A0,AF,EC)A(FF,E5,EA,FB)A(FF,E5,EA,FB)A(FF,D0,D8,F8)A(FF,96,A6,E5)A(FF,A0,AF,EC)A(FF,E5,EA,FB)A(FF,E5,EA,FB)A(FF,D0,D8,F8)A(FF,96,A6,E5)A(FF,A0,AF,EC)A(FF,E5,EA,FB)A(FF,E5,EA,FB)A(FF,D0,D8,F8)A(FF,96,A6,E5)A(FF,A0,AF,EC)A(FF,E5,EA,FB)A(FF,E5,EA,FB)A(FF,D0,D8,F8)A(FF,96,A6,E5)A(FF,A0,AF,EC)A(FF,E5,EA,FB)A(FF,E5,EA,FB)A(FF,D0,D8,F8)A(FF,96,A6,E5)A(FF,A0,AF,EC)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,EB,EF,FC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,F8,F9,FE)A(FF,EB,EF,FC)A(FF,EB,EF,FC)A(FF,FE,FE,FF)A(FF,FE,FE,FF)A(FF,F8,F9,FE)A(FF,EB,EF,FC)A(FF,EB,EF,FC)A(FF,FB,FB,FF)A(FF,F9,FB,FF)A(FF,F8,F9,FE)A(FF,EB,EF,FC)A(FF,EB,EF,FC)A(FF,F5,F7,FF)A(FF,F4,F6,FF)A(FF,F8,F9,FE)
				A(FF,EB,EF,FC)A(FF,EB,EF,FC)A(FF,EF,F3,FF)A(FF,EE,F1,FF)A(FF,F8,F9,FE)A(FF,EB,EF,FC)A(FF,EB,EF,FC)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FD,FF)A(FF,FC,FD,FF)A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,FA,FB,FF)A(FF,F9,FA,FF)A(FF,F7,FA,FF)A(FF,F6,F8,FF)A(FF,F6,F7,FF)A(FF,F5,F6,FF)A(FF,F3,F6,FF)A(FF,F2,F4,FF)A(FF,F1,F4,FF)A(FF,F0,F3,FF)A(FF,EF,F2,FF)A(FF,EE,F1,FF)A(FF,ED,F0,FF)A(FF,EC,F0,FF)A(FF,EB,F0,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FF,FF)A(FF,FE,FE,FF)A(FF,FD,FE,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,FB,FB,FF)A(FF,F9,FA,FF)A(FF,F8,FA,FF)A(FF,F7,F9,FF)A(FF,F6,F9,FF)A(FF,F5,F7,FF)A(FF,F4,F6,FF)
				A(FF,F3,F5,FF)A(FF,F2,F5,FF)A(FF,F0,F3,FF)A(FF,F0,F3,FF)A(FF,EE,F2,FF)A(FF,ED,F1,FF)A(FF,ED,F1,FF)A(FF,EC,EF,FF)A(FF,EC,EF,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FE,FF)A(FF,FE,FE,FF)A(FF,FD,FE,FF)A(FF,FD,FD,FF)A(FF,FB,FC,FF)A(FF,FB,FB,FF)A(FF,F9,FB,FF)A(FF,F8,FA,FF)A(FF,50,50,50)A(FF,CA,CB,D0)A(FF,F0,F2,FA)A(FF,F2,F5,FE)A(FF,F3,F5,FF)A(FF,F2,F4,FF)A(FF,F1,F3,FF)A(FF,F0,F3,FF)A(FF,EF,F1,FF)A(FF,ED,F1,FF)A(FF,ED,F0,FF)A(FF,EC,EF,FF)A(FF,EB,EF,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FF,FF)A(FF,FE,FD,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,FB,FB,FF)A(FF,FA,FB,FF)A(FF,F9,FB,FF)A(FF,5C,5D,5D)A(FF,5D,5C,5C)A(FF,5D,5D,5D);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_2 (a_ptr: POINTER; a_offset: INTEGER) is
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,AF,B1,B6)A(FF,ED,EE,F8)A(FF,F2,F4,FE)A(FF,F2,F4,FF)A(FF,F0,F3,FF)A(FF,EF,F3,FF)A(FF,EE,F1,FF)A(FF,ED,F0,FF)A(FF,EC,F0,FF)A(FF,EB,F0,FF)A(FF,EB,EF,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FE,FF)A(FF,FE,FE,FF)A(FF,FD,FE,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,FA,FB,FF)A(FF,71,71,72)A(FF,72,72,72)A(FF,72,72,71)A(FF,71,72,71)A(FF,71,71,71)A(FF,B5,B7,BB)A(FF,EA,EC,F7)A(FF,F0,F2,FE)A(FF,F0,F3,FF)A(FF,EF,F2,FF)A(FF,ED,F2,FF)A(FF,ED,F0,FF)A(FF,EC,F0,FF)A(FF,EB,EF,FF)A(FF,EB,EF,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FE,FF)A(FF,FE,FE,FF)A(FF,FC,FC,FF)A(FF,FB,FC,FF)A(FF,FB,FC,FF)A(FF,86,85,85)A(FF,85,85,85)A(FF,85,85,85)
				A(FF,85,85,86)A(FF,85,85,85)A(FF,85,85,85)A(FF,86,85,85)A(FF,BB,BD,C3)A(FF,E9,EB,F7)A(FF,EE,F2,FE)A(FF,EF,F2,FF)A(FF,EE,F1,FF)A(FF,EC,F0,FF)A(FF,EC,EF,FF)A(FF,EB,F0,FF)A(FF,EA,EF,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FF,FF)A(FF,FF,FE,FF)A(FF,FE,FE,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,93,93,93)A(FF,93,93,93)A(FF,93,93,93)A(FF,93,93,93)A(FF,93,93,93)A(FF,93,93,93)A(FF,93,93,93)A(FF,93,93,93)A(FF,93,93,93)A(FF,D4,D7,E1)A(FF,E9,EC,F9)A(FF,EF,F2,FF)A(FF,ED,F1,FF)A(FF,EC,F0,FF)A(FF,EC,F0,FF)A(FF,EB,EE,FF)A(FF,EB,EF,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FF,FF)A(FF,FF,FE,FF)A(FF,FD,FE,FF)A(FF,FD,FD,FF)A(FF,FC,FD,FF)A(FF,FB,FC,FF)A(FF,F4,F5,F9)A(FF,E4,E4,E9)
				A(FF,D5,D8,DC)A(FF,D2,D3,D9)A(FF,D1,D3,D9)A(FF,D0,D2,D9)A(FF,CF,D1,D9)A(FF,CE,D0,D9)A(FF,CF,D1,DB)A(FF,D8,DB,E6)A(FF,E7,E9,F6)A(FF,ED,F0,FE)A(FF,ED,F0,FF)A(FF,EC,F0,FF)A(FF,EC,EF,FF)A(FF,EB,EF,FF)A(FF,EA,EE,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,AB,B5,DC)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FF,FF,FF)A(FF,FE,FE,FF)A(FF,FD,FE,FF)A(FF,FD,FD,FF)A(FF,FC,FC,FF)A(FF,FB,FC,FF)A(FF,F7,F7,FC)A(FF,EF,F0,F5)A(FF,EB,EC,F2)A(FF,E9,EB,F2)A(FF,E9,EA,F2)A(FF,E8,E9,F2)A(FF,E7,E9,F2)A(FF,E6,E8,F2)A(FF,E5,E7,F2)A(FF,E7,E9,F5)A(FF,EA,EE,FB)A(FF,EE,F2,FF)A(FF,ED,F0,FF)A(FF,EC,EF,FF)A(FF,EB,EF,FF)A(FF,EA,EF,FF)A(FF,EA,EF,FF)A(FF,AB,B5,DC)A(FF,CE,D1,DA)A(FF,D5,D8,E2)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DA,DD,E7)A(FF,BD,C4,DF)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)
				A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,AB,B5,DC)A(FF,B7,BE,D9)A(FF,CE,D1,DA)A(FF,D6,D9,E3)A(FF,DA,DD,E7)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DB,DE,E8)A(FF,D7,DA,E4)A(FF,D0,D3,DC)A(FF,CC,CE,D8)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,C9,CC,D5)A(FF,CC,CE,D8)A(FF,D0,D3,DC)A(FF,D7,DA,E4)A(FF,DB,DE,E8)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DB,DE,E8)A(FF,D9,DC,E5)A(FF,D4,D7,E1)A(FF,D0,D3,DC)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)
				A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,CE,D1,DA)A(FF,D0,D3,DC)A(FF,D4,D7,E1)A(FF,D9,DC,E5)A(FF,DB,DE,E8)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DC,DF,E9)A(FF,DB,DE,E8)A(FF,D9,DC,E5)A(FF,D7,DA,E4)A(FF,D6,D9,E3)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D5,D8,E2)A(FF,D6,D9,E3)A(FF,D7,DA,E4)A(FF,D9,DC,E5)A(FF,DB,DE,E8)A(FF,DC,DF,E9)A(FF,DD,E0,EA)A(FF,81,90,D4)A(5C,00,00,00)A(3D,00,00,00)A(25,00,00,00)A(FF,81,90,D4)A(FF,AB,AD,B5)A(FF,CD,CF,D9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,DC,DF,E9)A(FF,DB,DE,E8)A(FF,DB,DE,E8)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	c_colors_3 (a_ptr: POINTER; a_offset: INTEGER) is
			-- Fill `a_ptr' with colors data from `a_offset'.
		external
			"C inline"
		alias
			"[
			{
				#define B(q) \
					#q
				#ifdef EIF_WINDOWS
				#define A(a,r,g,b) \
					B(\x##b\x##g\x##r\x##a)
				#else
				#define A(a,r,g,b) \
					B(\x##r\x##g\x##b\x##a)
				#endif
				char l_data[] = 
				A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DA,DD,E7)A(FF,DB,DE,E8)A(FF,DB,DE,E8)A(FF,DC,DF,E9)A(FF,DD,E0,EA)A(FF,DD,E0,EA)A(FF,81,90,D4)A(58,00,00,00)A(3B,00,00,00)A(23,00,00,00)A(9D,7B,8A,CB)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,80,8F,D3)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(FF,81,90,D4)A(C0,65,70,A5)A(51,00,00,00)A(36,00,00,00)A(20,00,00,00)A(0E,00,00,00)A(1C,00,00,00)A(2F,00,00,00)A(46,00,00,00)A(58,00,00,00)A(67,00,00,00)A(70,00,00,00)A(74,00,00,00)A(74,00,00,00)
				A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(74,00,00,00)A(70,00,00,00)A(67,00,00,00)A(58,00,00,00)A(46,00,00,00)A(2F,00,00,00)A(1C,00,00,00)A(0B,00,00,00)A(16,00,00,00)A(25,00,00,00)A(37,00,00,00)A(46,00,00,00)A(51,00,00,00)A(58,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(5C,00,00,00)A(58,00,00,00)A(51,00,00,00)A(46,00,00,00)A(37,00,00,00)A(25,00,00,00)A(16,00,00,00)A(07,00,00,00)A(0E,00,00,00)A(19,00,00,00)A(25,00,00,00)A(2F,00,00,00)A(36,00,00,00)A(3B,00,00,00)
				A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3D,00,00,00)A(3B,00,00,00)A(36,00,00,00)A(2F,00,00,00)A(25,00,00,00)A(19,00,00,00)A(0E,00,00,00)A(04,00,00,00)A(09,00,00,00)A(0E,00,00,00)A(16,00,00,00)A(1C,00,00,00)A(20,00,00,00)A(23,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(25,00,00,00)A(23,00,00,00)A(20,00,00,00)A(1C,00,00,00)A(16,00,00,00)A(0E,00,00,00)A(09,00,00,00);
				memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);
			}
			]"
		end

	build_colors (a_ptr: POINTER) is
			-- Build `colors'.
		do
			c_colors_0 (a_ptr, 0)
			c_colors_1 (a_ptr, 400)
			c_colors_2 (a_ptr, 800)
			c_colors_3 (a_ptr, 1200)
		end

feature {NONE} -- Image data filling.

	fill_memory is
			-- Fill image data into memory.
		local
			l_imp: EV_PIXEL_BUFFER_IMP
			l_pointer: POINTER
		do
			l_imp ?= implementation
			check not_void: l_imp /= Void end

			l_pointer := l_imp.data_ptr
			if l_pointer /= default_pointer then
				build_colors (l_pointer)
				l_imp.unlock
			end
		end

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- SD_UP_LIGHT_ICON
