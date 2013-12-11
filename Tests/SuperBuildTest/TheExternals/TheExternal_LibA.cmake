#
# LibA
#

set(proj LibA)
set(depends "")

superbuild_include_dependencies(${proj}
  PROJECT_VAR proj
  DEPENDENCIES_VAR depends
  EP_ARGS_VAR ep_args
  USE_SYSTEM_VAR ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj}
  )

include(${CMAKE_CURRENT_SOURCE_DIR}/ArtichokeCheckVariable.cmake)
check_variable(proj "LibA")
check_variable(depends "")
check_variable(${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj} "")

if(${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj})
  message(FATAL_ERROR "Enabling ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj} is not supported !")
endif()

# Sanity checks
if(DEFINED LibA_DIR AND NOT EXISTS ${LibA_DIR})
  message(FATAL_ERROR "LibA_DIR variable is defined but corresponds to non-existing directory")
endif()

if(NOT DEFINED LibA_DIR AND NOT ${CMAKE_PROJECT_NAME}_USE_SYSTEM_${proj})

  ExternalProject_Add(${proj}
    ${ep_args}
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Lib
    BINARY_DIR ${proj}-build
    DOWNLOAD_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    DEPENDS ${depends}
    )
  set(LibA_DIR ${CMAKE_BINARY_DIR}/${proj}-build)

else()
  superbuild_add_empty_external_project(${proj} "${depends}")
endif()

mark_as_superbuild(
  VARS LibA_DIR:PATH
  LABELS "FIND_PACKAGE"
  )
