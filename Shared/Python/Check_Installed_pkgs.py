import pkgutil
import platform
import sys

# Multi Operating System support values
OS_UNKNOWN	= 0
OS_LINUX 	= 1
OS_MACOSX	= 2
OS_WINDOWS	= 4
OS_FREEBSD	= 8
OS_OPENBSD	= 16
OS_WHATNOT	= 32

OS_SUPPORTED = OS_LINUX | OS_MACOSX | OS_WINDOWS | OS_FREEBSD

# print severity levels:
# 	0	always
#	1	verbose (common.VERBOSE)
#	2	debug   (common.DEBUG)
# print feedback levels:
#	-1	negativ
#	0	neutral
#	1	positive
colour = False
VERBOSE = 1
DEBUG   = 2

def internal_print(message, feedback = 0, verbosity = 0, severity = 0):
	debug = ""
	if severity == 2:
		debug = "DEBUG: "
	if verbosity >= severity:
		if feedback == -1:
			if colour:
				prefix = "\033[91m[-]"
		if feedback == 0:
			if colour:
				prefix = "\033[39m[*]"
		if feedback == 1:
			if colour:
				prefix = "\033[92m[+]"
		if colour:
			print("{0} {1}{2}\033[39m".format(prefix, debug, message))
		else:
			print("{0}{1}".format(debug, message))

# check if the OS is supported
def os_support(OS_support):
	if get_os_type() in OS_support:
		return True
	else:
		internal_print("Sorry buddy, I am afraid that your OS is not yet supported.", -1)
		return False

def get_os_type():
    # get the release of the OS 

	os_type = platform.system()
	if os_type == "Linux":
		return "OS_LINUX"

	if os_type == "Darwin":
		return "OS_MACOSX"

	if os_type == "Windows":
		return "OS_WINDOWS"

	if os_type == "FreeBSD":
		return "OS_FREEBSD"

	if os_type == "OpenBSD":
		return "OS_OPENBSD"

	return "OS_UNKNOWN"

def check_modules_installed(reqs):

	allinstalled = True
	for m in reqs:
		if not pkgutil.find_loader(m):
			allinstalled = False
			internal_print("The following python module was not installed: {0}".format(m), -1)

	return allinstalled

if __name__ == "__main__":
	# Load args
	args = sys.argv
	OS_support = []
	ls_pkgs    = []
	for i in range(1, len(args)):
		if 'OS_' in sys.argv[i]:
			OS_support.append(sys.argv[i])
		else:
			ls_pkgs.append(sys.argv[i])

	if not os_support(OS_support):
		sys.exit()

    # Check if the 'example' package is installed
	reqs = []
	os_type = get_os_type()

	# reqs = [["module_name"], [...]]

	if os_type == 'OS_LINUX':
		reqs = ls_pkgs
	if os_type == 'OS_MACOSX':
		reqs = ls_pkgs
	if os_type == 'OS_WINDOWS':
		reqs = ls_pkgs

	if check_modules_installed(reqs):
		# internal_print("OS system and installed packages are supported.", 1)
		print("True")