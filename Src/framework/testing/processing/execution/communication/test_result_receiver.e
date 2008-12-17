indexing
	description: "[
		Objects that receive testing results through a socket. Since this is done in a seperate thread,
		the receiver only has access to the evaluator status.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	TEST_RESULT_RECEIVER

inherit
	EXECUTION_ENVIRONMENT

feature -- Access

	last_port: INTEGER
			-- Port on which new socket is listening

feature {NONE} -- Access

	port_counter: !CELL [INTEGER]
			-- Counter for port number `Current' listens to
		once
			create Result.put (0)
		end

	min_port: INTEGER = 49152
			-- Smallest valid port number

	max_port: INTEGER = 65535
			-- Largest valid port number

feature -- Status setting

	receive (a_status: !TEST_EVALUATOR_STATUS) is
			-- Wait for incoming connection on socket.
			--
			-- Note: `receive' will open a listener socket on a arbitrary available port and simply try to
			--       receive objects of type {EQA_TEST_OUTCOME}. If `a_status' does not have any remaining tests
			--       or something unexpected is received, the connection is closed and the listener thread
			--       terminated. `last_port' will be set to the port on which the new listener thread is
			--       waiting for incoming connections.
			--
			-- `a_status': Status to which received results are added
		local
			l_socket: ?NETWORK_STREAM_SOCKET
			l_thread: WORKER_THREAD
			l_tries: NATURAL
		do
			from until
				(l_socket /= Void and then l_socket.is_open_read) or l_tries > 20
			loop
				port_counter.put (port_counter.item + 1)
				if port_counter.item < min_port or port_counter.item > max_port then
					port_counter.put (min_port)
				end
				last_port := port_counter.item
				create l_socket.make_server_by_port (last_port)
				l_tries := l_tries + 1
			end
			if l_socket /= Void and then l_socket.is_open_read then
				a_status.set_listening
				l_socket.set_blocking
				l_socket.listen (1)
				create l_thread.make (agent listen (l_socket, a_status))
				l_thread.launch
			else
				-- TODO: error handling
			end
		ensure
			last_port_valid: last_port >= min_port and last_port <= max_port
		end

feature {NONE} -- Implementation

	listen (a_socket: !NETWORK_STREAM_SOCKET; a_status: !TEST_EVALUATOR_STATUS) is
			-- Wait for incoming connection on socket and receive results.
			--
			-- `a_socket': Socket to which evaluator will connect to.
			-- `a_status': Status where new results are added.
		require
			a_status_is_listening: a_status.is_listening
		local
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				a_socket.accept
				if {l_receiver: !NETWORK_STREAM_SOCKET} a_socket.accepted then
					receive_results (l_receiver, a_status)
				end
			end
			a_status.set_disconnected
		rescue
			l_rescued := True
			retry
		end

	receive_results (a_socket: NETWORK_STREAM_SOCKET; a_status: !TEST_EVALUATOR_STATUS) is
			-- Receive results from socket.
			--
			-- `a_socket': Socket through which evaluator sends results.
			-- `a_status': Status where new results are added.
		local
			l_rescued, l_stop: BOOLEAN
			l_next, l_flag: NATURAL
		do
			if not l_rescued then
				from until
					not a_socket.is_open_read or a_status.is_finished or l_stop
				loop
					l_stop := True
					l_next := a_status.next
					if l_next > 0 then
						a_socket.put_natural (l_next)
						l_flag := evaluator_status (a_socket)
						if l_flag = l_next then
							if {l_outcome: !EQA_TEST_OUTCOME} a_socket.retrieved then
								a_status.put_outcome (l_outcome)
								l_stop := False
							end
						end
					end
				end
			end
			a_socket.close
		ensure
			a_socket_closed: a_socket.is_closed
		rescue
			l_rescued := True
			retry
		end

	evaluator_status (a_socket: NETWORK_STREAM_SOCKET): NATURAL
			-- Current status of evaluator.
			--
			-- Note: this routine will block until evaluator sends its status through the socket.
			--
			-- `a_socket': Socket through which evaluator sends results
			-- `Result': '1' if evaluator is about to send a result, '0' otherwise
		local
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				from
				until
					a_socket.readable or a_socket.is_closed
				loop
					sleep (100000000)
				end
				if a_socket.readable then
					a_socket.read_natural_32
					Result := a_socket.last_natural_32
				end
			end
		rescue
			l_rescued := True
			retry
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
