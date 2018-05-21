# Choose here Geant4 version to use by setting its path.
set(GEANT4_DIR "$ENV{HOME}/geant4.10.03.p03/geant4.10.03.p03-install/lib64/Geant4-10.3.2")
set(GEANT4_VERSION "10.03.p03")

# Edit the branch name.
set(CTEST_GIT_BRANCH "develop")
# Edit the name of the repository to be cloned and tested.
set(CTEST_GIT_REPOSITORY "Gate")
# Edit the URL of the repository.
set(CTEST_GIT_URL "https://github.com/OpenGATE")

# Specific options
set(CTEST_CONFIGURE_COMMAND_OPTIONS "\"-DGATE_USE_ITK:BOOL=OFF\"")
set(CTEST_SPECIFIC_OPTION "_ITKOFF")

include("$ENV{SCRIPT_DIRECTORY}/linux15_lin64/linux15_lin64_common.cmake")
