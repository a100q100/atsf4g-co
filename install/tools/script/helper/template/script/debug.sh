<%!
    import common.project_utils as project
%><%include file="common.template.sh" />
<%
import os

valgrind_tool = project.get_global_option('valgrind', 'tool', '', 'SYSTEM_MACRO_CUSTOM_VALGRIND_TOOL').strip()
if len(valgrind_tool) > 0:
	profile_dir = project.get_global_option('valgrind', 'profile_dir', '', 'SYSTEM_MACRO_CUSTOM_PROFILE_DIR')
	if 0 != len(profile_dir):
		profile_dir = os.path.join('$PROJECT_INSTALL_DIR', profile_dir)
	else:
		profile_dir = '$PROFILE_DIR'
	valgrind_options = project.get_global_option('valgrind', 'option', '', 'SYSTEM_MACRO_CUSTOM_VALGRIND_OPTIONS')

	valgrind_tool = 'valgrind --tool={0} --log-file="{1}" {2} '.format(
		valgrind_tool, os.path.join(profile_dir, '$SERVER_NAME.%p.valgrind'), valgrind_options
	)
%>

if [ -z "$DEBUG_BIN" ]; then
    export DEBUG_BIN=gdb ;
fi

<%
if len(valgrind_tool) > 0:
    valgrind_tool = valgrind_tool + '--vgdb=full '
else:
    valgrind_tool = '$DEBUG_BIN --args '
%>
${valgrind_tool}./$SERVERD_NAME -id $SERVER_BUS_ID -c ../etc/$SERVER_FULL_NAME.conf -p $SERVER_PID_FILE_NAME start "$@"

