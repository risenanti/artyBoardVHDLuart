# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/keith/Documents/github/kintechUart/serialPortSoftware

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/keith/Documents/github/kintechUart/serialPortSoftware/build

# Include any dependencies generated for this target.
include CMakeFiles/serialPortRead.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/serialPortRead.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/serialPortRead.dir/flags.make

CMakeFiles/serialPortRead.dir/main.cpp.o: CMakeFiles/serialPortRead.dir/flags.make
CMakeFiles/serialPortRead.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/keith/Documents/github/kintechUart/serialPortSoftware/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/serialPortRead.dir/main.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/serialPortRead.dir/main.cpp.o -c /home/keith/Documents/github/kintechUart/serialPortSoftware/main.cpp

CMakeFiles/serialPortRead.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/serialPortRead.dir/main.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/keith/Documents/github/kintechUart/serialPortSoftware/main.cpp > CMakeFiles/serialPortRead.dir/main.cpp.i

CMakeFiles/serialPortRead.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/serialPortRead.dir/main.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/keith/Documents/github/kintechUart/serialPortSoftware/main.cpp -o CMakeFiles/serialPortRead.dir/main.cpp.s

CMakeFiles/serialPortRead.dir/main.cpp.o.requires:

.PHONY : CMakeFiles/serialPortRead.dir/main.cpp.o.requires

CMakeFiles/serialPortRead.dir/main.cpp.o.provides: CMakeFiles/serialPortRead.dir/main.cpp.o.requires
	$(MAKE) -f CMakeFiles/serialPortRead.dir/build.make CMakeFiles/serialPortRead.dir/main.cpp.o.provides.build
.PHONY : CMakeFiles/serialPortRead.dir/main.cpp.o.provides

CMakeFiles/serialPortRead.dir/main.cpp.o.provides.build: CMakeFiles/serialPortRead.dir/main.cpp.o


# Object files for target serialPortRead
serialPortRead_OBJECTS = \
"CMakeFiles/serialPortRead.dir/main.cpp.o"

# External object files for target serialPortRead
serialPortRead_EXTERNAL_OBJECTS =

serialPortRead: CMakeFiles/serialPortRead.dir/main.cpp.o
serialPortRead: CMakeFiles/serialPortRead.dir/build.make
serialPortRead: /usr/lib/x86_64-linux-gnu/libQt5SerialPort.so.5.5.1
serialPortRead: /usr/lib/x86_64-linux-gnu/libQt5Widgets.so.5.5.1
serialPortRead: /usr/lib/x86_64-linux-gnu/libQt5Gui.so.5.5.1
serialPortRead: /usr/lib/x86_64-linux-gnu/libQt5Core.so.5.5.1
serialPortRead: CMakeFiles/serialPortRead.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/keith/Documents/github/kintechUart/serialPortSoftware/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable serialPortRead"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/serialPortRead.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/serialPortRead.dir/build: serialPortRead

.PHONY : CMakeFiles/serialPortRead.dir/build

CMakeFiles/serialPortRead.dir/requires: CMakeFiles/serialPortRead.dir/main.cpp.o.requires

.PHONY : CMakeFiles/serialPortRead.dir/requires

CMakeFiles/serialPortRead.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/serialPortRead.dir/cmake_clean.cmake
.PHONY : CMakeFiles/serialPortRead.dir/clean

CMakeFiles/serialPortRead.dir/depend:
	cd /home/keith/Documents/github/kintechUart/serialPortSoftware/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/keith/Documents/github/kintechUart/serialPortSoftware /home/keith/Documents/github/kintechUart/serialPortSoftware /home/keith/Documents/github/kintechUart/serialPortSoftware/build /home/keith/Documents/github/kintechUart/serialPortSoftware/build /home/keith/Documents/github/kintechUart/serialPortSoftware/build/CMakeFiles/serialPortRead.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/serialPortRead.dir/depend

