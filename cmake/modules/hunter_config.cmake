# Copyright (c) 2013-2014, Ruslan Baratov
# All rights reserved.

include(CMakeParseArguments) # cmake_parse_arguments

include(hunter_unsetvar)
include(hunter_user_error)

# internal variables: _hunter_*
macro(hunter_config)
  set(_hunter_one_value VERSION)
  set(_hunter_multiple_values CMAKE_ARGS)
  cmake_parse_arguments(
      _hunter
      ""
      "${_hunter_one_value}"
      "${_hunter_multiple_values}"
      ${ARGV}
  )
  list(LENGTH _hunter_UNPARSED_ARGUMENTS _hunter_len)
  if(NOT ${_hunter_len} EQUAL 1)
    hunter_user_error(
        "Unparsed arguments for 'hunter_config' command: "
        "${_hunter_UNPARSED_ARGUMENTS}"
    )
  endif()

  # calc <NAME>_ROOT
  list(GET _hunter_UNPARSED_ARGUMENTS 0 _hunter_current_project)
  string(TOUPPER "${_hunter_current_project}" _hunter_root)
  set(_hunter_root "${_hunter_root}_ROOT")

  # clear all
  hunter_unsetvar(${_hunter_root})

  if(_hunter_VERSION)
    set(HUNTER_${_hunter_current_project}_VERSION ${_hunter_VERSION})
    set(HUNTER_${_hunter_current_project}_CMAKE_ARGS ${_hunter_CMAKE_ARGS})
  else()
    hunter_user_error("Expected VERSION option for 'hunter_config' command")
  endif()
endmacro()
