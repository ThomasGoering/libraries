note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SERVER_CONTROL

inherit
	XU_SHARED_OUTPUTTER

 create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature {NONE} -- Constants

	default_cmd_server_port: INTEGER = 55002

	default_cmd_server_host: STRING = "localhost" -- FIXME: read this from  config file


feature -- Access

feature -- Status report

feature -- Status setting

feature -- Operations

	send (a_command: XC_SERVER_COMMAND): XC_COMMAND_RESPONSE
			-- Sends a command to the server and waits for the response
		require
			a_command_attached: a_command /= Void
		local
			l_socket: NETWORK_STREAM_SOCKET
		do
			Result := create {XCCR_INTERNAL_SERVER_ERROR}

			create l_socket.make_client_by_port (default_cmd_server_port, default_cmd_server_host)
			o.dprint ("Connecting...", 3)
			l_socket.connect
            if  l_socket.is_connected then
            	o.dprint("Sending command...", 3)
            	l_socket.put_natural (0)
		        l_socket.independent_store (a_command)

		        if a_command.has_response then
		        	o.dprint ("Waiting for response", 2)
		            l_socket.read_natural
					if attached {XC_COMMAND_RESPONSE} l_socket.retrieved as l_response then
						o.dprint ("Response retrieved", 2)
		            	Result := l_response
		            else
		            	Result := create {XCCR_CANNOT_SEND}
	            	end
		        else
		        	Result := create {XCCR_NO_RESPONSE}
		        end
	        else
	        	Result := create {XCCR_CANNOT_SEND}
	        end
		ensure
			result_attached: Result /= Void
		end


end

