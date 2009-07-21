note
	description: "[
		No comment yet.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XSWA_COMPILE_SGEN

inherit
	XS_WEBAPP_ACTION
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_webapp: XS_WEBAPP)
			-- Initialization for `Current'.	
		do
			Precursor (a_webapp)
			create output_handler_compile.make
		ensure then
			output_handler_compile_attached: output_handler_compile /= Void
		end

feature -- Access

	output_handler_compile: XSOH_COMPILE
			-- Output handler for compilation process

	gen_compile_process: detachable PROCESS
			-- Used to compile the servlet_gen			


	gen_compiler_args: STRING
			-- The arguments that are passed to compile the servlet_gen	
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			create l_f_utils
			Result  := " -config " + servlet_gen_ecf.string + " -target servlet_gen -c_compile -stop"
			if webapp.needs_cleaning then
				Result.append (" -clean")
			end
			if not l_f_utils.is_readable_file (servlet_gen_exe) then
				Result.append (" -clean")
			end
			if {XU_CONSTANTS}.experiment_library then
				Result.append (" -experiment")
			end
		ensure
			Result_attached: Result /= void
		end


feature -- Status report

	is_necessary: BOOLEAN
		--


		local
			l_f_util: XU_FILE_UTILITIES
			l_melted_file_is_old: BOOLEAN
			l_executable_does_not_exist: BOOLEAN
		do
			create l_f_util
			l_melted_file_is_old := l_f_util.file_is_newer (servlet_gen_melted_file_path,
												servlet_gen_path,
												"\w+\.(e|ecf)")
			l_executable_does_not_exist := not l_f_util.is_executable_file (servlet_gen_exe)

			Result := l_melted_file_is_old or l_executable_does_not_exist or webapp.needs_cleaning

			if Result then
				o.dprint ("Compiling servlet_gen is necessary", 3)
				if l_melted_file_is_old then
					o.dprint ("Compiling servlet_gen is necessary because: " + servlet_gen_melted_file_path + " is older than .e files or .ecf file.", 5)
				end

				if l_executable_does_not_exist then
					o.dprint ("Compiling servlet_gen is necessary because: " + servlet_gen_exe + " does not exist or is not executable", 5)
				end

					if webapp.needs_cleaning then
					o.dprint ("Compiling servlet_gen is necessary because: webapp needs cleaning.", 5)
				end

			else
				o.dprint ("Compiling servlet_gen is not necessary", 3)
			end
		end

feature -- Status setting

	stop
			-- <Precursor>
		do
			if attached {PROCESS} gen_compile_process as p and then p.is_running  then
				o.dprint ("Terminating gen_compile_process for " + webapp.app_config.name.out  + "", 2)
				p.terminate
				p.wait_for_exit
			end
			set_running (False)
		end


feature {NONE} -- Internal Status Setting

	set_running (a_running: BOOLEAN)
			-- Sets is_running
		do
			is_running := a_running
			webapp.is_compiling_servlet_gen := a_running
		ensure
			set: equal (is_running, a_running)
			set: equal (is_running, webapp.is_compiling_servlet_gen)
		end

feature {TEST_WEBAPPS} -- Implementation

	internal_execute: XC_COMMAND_RESPONSE
			-- <Precursor>
		local
			l_f_utils: XU_FILE_UTILITIES
		do
			if not is_running then
				create l_f_utils
				if can_launch_process (config.file.compiler_filename, app_dir) and then l_f_utils.is_readable_file (servlet_gen_ecf) then
					if attached gen_compile_process as p  then
						if p.is_running then
							o.eprint ("About to launch gen_compile_process but it was still running... So I'm going to kill it.", generating_type)
							p.terminate
						end
					end
					set_running (True)
					o.dprint("-=-=-=--=-=LAUNCHING COMPILE SERVLET GEN-=-=-=-=-=-=", 6)
					gen_compile_process := launch_process (config.file.compiler_filename,
															gen_compiler_args,
															app_dir,
															agent gen_compile_process_exited,
															agent output_handler_compile.handle_output,
															agent output_handler_compile.handle_output)
				end
			end
			Result := (create {XER_APP_COMPILING}.make (webapp.app_config.name.out)).render_to_command_response
		end


feature -- Agents

	gen_compile_process_exited
			-- Launch executing of servlet_gen in genrate_process
		do
			set_running (False)
			if not is_necessary then
				execute_next_action.do_nothing
			else
				o.eprint ("COMPILATION OF SERVLET_GEN FAILED", generating_type)

			end
		end

invariant
	output_handler_compile_attached: output_handler_compile /= Void
end

