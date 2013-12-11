#
# LibB
#

set(proj LibB)

set(${proj}_DEPENDENCIES LibA)

superbuild_include_dependencies(PROJECT_VAR proj)

include(${CMAKE_CURRENT_SOURCE_DIR}/ArtichokeCheckVariable.cmake)
check_variable(proj "LibB")
check_variable(${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj} "")

if(${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj})
  message(FATAL_ERROR "Enabling ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj} is not supported !")
endif()

# Sanity checks
if(DEFINED LibB_DIR AND NOT EXISTS ${LibB_DIR})
  message(FATAL_ERROR "LibB_DIR variable is defined but corresponds to non-existing directory")
endif()

if(NOT DEFINED LibB_DIR AND NOT ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj})

  ExternalProject_Add(${proj}
    ${${proj}_EXTERNAL_PROJECT_ARGS}
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Lib
    BINARY_DIR ${proj}-build
    DOWNLOAD_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    DEPENDS
      ${${proj}_DEPENDENCIES}
    )
  set(LibB_DIR ${CMAKE_BINARY_DIR}/${proj}-build)

else()
  superbuild_add_empty_external_project(${proj} "${${proj}_DEPENDENCIES}")
endif()

mark_as_superbuild(
  VARS LibB_DIR:PATH
  LABELS "FIND_PACKAGE"
  )