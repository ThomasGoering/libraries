note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class RUNNER_ING

inherit
	RDB_HANDLE

create
	make

feature {NONE}

	base_change: DB_CHANGE

	proc: DB_PROC

	repository: DB_REPOSITORY
			
	session_control: DB_CONTROL

	data_file: PLAIN_TEXT_FILE

	book: BOOK2
	
feature 

	make
		local
			tmp_string: STRING
		do
			io.putstring ("Database user authentication:%N")
			io.putstring ("Database name: ")
			io.readline
			set_data_source (io.laststring)
			io.putstring ("Name: ")
			io.readline
			tmp_string := io.laststring.twin
			io.putstring ("Password: ")
			io.readline
			login (tmp_string, io.laststring)
			set_base

			create session_control.make
			create base_change.make

			create book.make

			session_control.connect

			if not session_control.is_connected then
				session_control.raise_error
				io.putstring ("Can't connect to database.%N")
			else
				create repository.make (Table_name)
				repository.load
				if repository.exists then
					make_change_ing
					session_control.disconnect
				else
					io.putstring ("Table not found!");
				end
			end
		end

feature {NONE}

	make_change_ing
		local
			author: STRING
			price: REAL
			pub_date: DATE_TIME
		do
			create author.make (10)
			price := 51
			create pub_date.make_now 

			create proc.make (Proc_name)
			proc.load
				proc.set_arguments (<<"author", "price", "pub_date">>,
							<<author, price, pub_date >>)

			if proc.exists then
				io.putstring ("Stored procedure text: ")
				io.putstring (proc.text)
				io.new_line
			else
				proc.store (Select_text)
				io.putstring ("Procedure created.%N")
				proc.load
			end

			from
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			until
				io.laststring.is_equal ("exit")
			loop
				author := io.laststring.twin
				io.putstring ("Seeking for books whose author's name match: ")
				io.putstring (author)
				io.new_line
				io.new_line

				base_change.set_map_name (pub_date, "pub_date")
				base_change.set_map_name (price, "price")
				base_change.set_map_name (author, "author")

				proc.execute (base_change)

				base_change.unset_map_name ("author")
				base_change.unset_map_name ("price")
				base_change.unset_map_name ("pub_date")

				io.new_line
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			end
		end
	
feature {NONE}

	Select_text: STRING =
		"update db_book set author = author, price = :price, year = :pub_date where author = :author"

	Table_name: STRING = "DB_BOOK"

	Proc_name: STRING = "DB_BOOK_PROC";

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
