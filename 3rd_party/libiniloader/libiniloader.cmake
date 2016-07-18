﻿
# =========== 3rdparty libiniloader ==================
if(NOT 3RD_PARTY_LIBINILOADER_BASE_DIR)
    set (3RD_PARTY_LIBINILOADER_BASE_DIR ${CMAKE_CURRENT_LIST_DIR})
endif()

set (3RD_PARTY_LIBINILOADER_REPO_DIR "${3RD_PARTY_LIBINILOADER_BASE_DIR}/repo")

if(NOT EXISTS ${3RD_PARTY_LIBINILOADER_REPO_DIR})
    find_package(Git)
    if(NOT GIT_FOUND)
        message(FATAL_ERROR "git not found")
    endif()

    file(RELATIVE_PATH 3RD_PARTY_LIBINILOADER_GIT_SUBMODULE_PATH ${CMAKE_SOURCE_DIR} ${3RD_PARTY_LIBINILOADER_REPO_DIR})
    execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init ${3RD_PARTY_LIBINILOADER_GIT_SUBMODULE_PATH}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
endif()

set (3RD_PARTY_LIBINILOADER_INC_DIR ${3RD_PARTY_LIBINILOADER_REPO_DIR})
set (3RD_PARTY_LIBINILOADER_SRC_DIR ${3RD_PARTY_LIBINILOADER_REPO_DIR})
# set (3RD_PARTY_LIBINILOADER_LINK_NAME)

include_directories(${3RD_PARTY_LIBINILOADER_INC_DIR})
list(APPEND PROJECT_3RD_PARTY_SRC_LIST "${3RD_PARTY_LIBINILOADER_REPO_DIR}/ini_loader.cpp")
