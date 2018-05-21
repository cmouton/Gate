# To be edited to fit your architecture and your chosen settings.
# The 2 following settings will be displayed on the dashboard.
set(CTEST_SITE "travis-ci")
set(CTEST_BUILD_NAME "linux-gcc_4.8.3-geant4_${GEANT4_VERSION}-${CTEST_GIT_REPOSITORY}-${CTEST_GIT_BRANCH}${CTEST_SPECIFIC_OPTION}")
set(CTEST_BUILD_CONFIGURATION Release)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
# Number of cores for parallel build with make
set(CTEST_BUILD_FLAGS "-j8")
# Number of cores parallel testing
set(CTEST_TEST_ARGS PARALLEL_LEVEL 8)

# Specific common options
set(CTEST_CONFIGURE_COMMAND_COMMON_OPTIONS "\"-DROOTCINT_EXECUTABLE:STRING=$ENV{ROOT_DIRECTORY}/bin/rootcint\"
                                            \"-DROOT_CONFIG_EXECUTABLE:STRING=$ENV{SCRIPT_DIRECTORY}/bin/root-config\""
  )

if (NOT CTEST_SPECIFIC_OPTION STREQUAL "_ITKOFF")
  set(CTEST_CONFIGURE_COMMAND_COMMON_OPTIONS "${CTEST_CONFIGURE_COMMAND_COMMON_OPTIONS} \"-DITK_DIR:STRING=/home/srit/src/itk/lin64-dg\"")
endif (CTEST_SPECIFIC_OPTION STREQUAL "_ITKOFF")

# ----------------------------------------------------------------------------
# Send the main script as a note.
list(APPEND CTEST_NOTES_FILES
     "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}"
     "${CMAKE_CURRENT_LIST_FILE}"
    )
# ----------------------------------------------------------------------------

include("$ENV{SCRIPT_DIRECTORY}/common/opengate_common.cmake")
