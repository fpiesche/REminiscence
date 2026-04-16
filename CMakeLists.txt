cmake_minimum_required (VERSION 3.21)

# Build universal binaries on macOS
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
    set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "" FORCE)
endif()

project(reminiscence VERSION 1.0.3 LANGUAGES CXX)

set(DIST_PATH "${CMAKE_CURRENT_SOURCE_DIR}/dist")
set(FREEDESKTOP_APP_ID "net.yellowkeycard.reminiscence")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(git_version)
get_version_from_git()

option("USE_ZLIB" "Use zlib" ON)

list(APPEND SOURCES
    src/collision.cpp
    src/cpc_player.cpp
    src/cutscene.cpp
    src/decode_mac.cpp
    src/file.cpp
    src/fs.cpp
    src/game.cpp
    src/graphics.cpp
    src/main.cpp
    src/menu.cpp
    src/midi_parser.cpp
    src/mixer.cpp
    src/mod_player.cpp
    src/ogg_player.cpp
    src/piege.cpp
    src/prf_player.cpp
    src/protection.cpp
    src/resource.cpp
    src/resource_aba.cpp
    src/resource_mac.cpp
    src/resource_paq.cpp
    src/scaler.cpp
    src/screenshot.cpp
    src/seq_player.cpp
    src/sfx_player.cpp
    src/staticres.cpp
    src/systemstub_sdl.cpp
    src/unpack.cpp
    src/util.cpp
    src/video.cpp
)

find_package(SDL2 REQUIRED)
list(APPEND REMINISCENCE_LIBRARIES SDL2)

list(APPEND REMINISCENCE_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${SDL2_INCLUDE_DIR}
)

if(USE_ZLIB)
    find_package(ZLIB REQUIRED)
    list(APPEND REMINISCENCE_INCLUDE_DIRS ${ZLIB_INCLUDE_DIR})
    list(APPEND REMINISCENCE_LIBRARIES ZLIB::ZLIB)
endif()

include(audio_drivers)

add_executable(reminiscence ${SOURCES})
target_include_directories(reminiscence PUBLIC ${REMINISCENCE_INCLUDE_DIRS})
target_compile_options(reminiscence BEFORE PUBLIC ${REMINISCENCE_COMPILE_OPTS})
target_link_directories(reminiscence PUBLIC ${REMINISCENCE_LINK_DIRS})
target_link_libraries(reminiscence ${REMINISCENCE_LIBRARIES})

include(install)
include(packaging)
