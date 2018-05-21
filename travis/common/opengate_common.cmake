# Common part to be included at the end of your specific CTest script.


set(CTEST_DASHBOARD_ROOT $ENV{DASHBOARD_ROOT}/${CTEST_GIT_REPOSITORY}-${CTEST_GIT_BRANCH})

set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}")

set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}-bin-${GEANT4_VERSION}${CTEST_SPECIFIC_OPTION}")
set(ENV{GATE_BINARY} ${CTEST_BINARY_DIRECTORY}/Gate)


# ----------------------------------------------------------------------------

# Empty binary directory before setting initial cache.
ctest_empty_binary_directory(${CTEST_BINARY_DIRECTORY})

# Source management through git.
find_program(CTEST_GIT_COMMAND NAMES git)

# Clone the appropriate branch of the opengate repository.
if(NOT EXISTS "${CTEST_SOURCE_DIRECTORY}")
   # The command that will be run is:
   # git clone -b ${CTEST_GIT_BRANCH} ${CTEST_GIT_URL}/${CTEST_GIT_REPOSITORY}.git ${CTEST_SOURCE_DIRECTORY}
   set(CTEST_CHECKOUT_COMMAND
      "${CTEST_GIT_COMMAND} clone -b ${CTEST_GIT_BRANCH} ${CTEST_GIT_URL}/${CTEST_GIT_REPOSITORY}.git ${CTEST_SOURCE_DIRECTORY}")
endif()

set(CTEST_UPDATE_COMMAND "${CTEST_GIT_COMMAND}")

# ----------------------------------------------------------------------------

# Send this script as a note.
list(APPEND CTEST_NOTES_FILES
     "$ENV{SCRIPT_DIRECTORY}/common/opengate_common.cmake"  
     ""
    )

# ----------------------------------------------------------------------------


# Compilation flags enabling all warnings and providing the path for Geant4.
set(WARNING_FLAGS_FOR_COMPILATION "-W -Wno-unused-parameter -Wno-attributes")
set(ECAT7_HOME_PATH "/home/mouton/src/ecat7")
set(CTEST_CONFIGURE_COMMAND "${CMAKE_COMMAND} -DBUILD_TESTING:BOOL=ON")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"-DGATE_DOWNLOAD_BENCHMARKS_DATA:BOOL=ON\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"-DCMAKE_BUILD_TYPE:STRING=${CTEST_BUILD_CONFIGURATION}\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"-G${CTEST_CMAKE_GENERATOR}\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"-DCMAKE_CXX_FLAGS:STRING=${WARNING_FLAGS_FOR_COMPILATION}\"
                            \"-DCMAKE_C_FLAGS:STRING=${WARNING_FLAGS_FOR_COMPILATION}\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"-DGeant4_DIR:PATH=${GEANT4_DIR}\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"-DGATE_USE_ITK:BOOL=ON\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"-DGATE_USE_ECAT7:BOOL=ON\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"-DECAT7_HOME:PATH=${ECAT7_HOME_PATH}\"")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                             ${CTEST_CONFIGURE_COMMAND_OPTIONS}")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                             ${CTEST_CONFIGURE_COMMAND_COMMON_OPTIONS}")
set(CTEST_CONFIGURE_COMMAND "${CTEST_CONFIGURE_COMMAND}
                            \"${CTEST_SOURCE_DIRECTORY}\"")


ctest_start(Experimental)
ctest_update()
ctest_configure()
ctest_build()
#ctest_test()
ctest_submit()
