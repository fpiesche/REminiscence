option("USE_MODPLUG" "Use libmodplug" ON)
option("USE_ADLIB" "Include AdLib MIDI driver via Nuked-OPL3" ON)
option("USE_MT32EMU" "Include MT-32 MIDI driver via mt32emu" ON)
option("USE_TREMOR" "Use Tremor for ogg playback on non-FPU systems" OFF)

if(USE_MODPLUG)
    message(STATUS "[AUDIO] MOD playback enabled")
    find_package(PkgConfig)
    pkg_check_modules(MODPLUG libmodplug)
    list(APPEND REMINISCENCE_LIBRARIES ${MODPLUG_LIBRARIES})
    list(APPEND REMINISCENCE_INCLUDE_DIRS ${MODPLUG_INCLUDE_DIRS})
    list(APPEND REMINISCENCE_LINK_DIRS ${MODPLUG_LIBRARY_DIRS})
else()
    message(STATUS "[AUDIO] MOD playback disabled")
endif()

if(USE_MT32EMU)
    message(STATUS "[AUDIO] MT-32 MIDI emulation enabled")
    find_package(MT32Emu REQUIRED)
    list(APPEND REMINISCENCE_LIBRARIES ${MT32EMU_LIBRARIES})
    list(APPEND REMINISCENCE_INCLUDE_DIRS ${MT32EMU_INCLUDE_DIRS})
    list(APPEND SOURCES "src/midi_driver_mt32.cpp")
endif()


if(USE_ADLIB)
    message(STATUS "[AUDIO] Nuked-OPL3 AdLib MIDI driver enabled")
    include(FetchContent)
    FetchContent_Declare(
        nukedopl3
        GIT_REPOSITORY https://github.com/nukeykt/Nuked-OPL3.git
        GIT_TAG        cfedb09efc03f1d7b5fc1f04dd449d77d8c49d50
    )
    FetchContent_MakeAvailable(nukedopl3)
    list(APPEND SOURCES "src/midi_driver_adlib.cpp")
    list(APPEND REMINISCENCE_INCLUDE_DIRS ${nukedopl3_SOURCE_DIR})
endif()

if(NOT USE_TREMOR)
    message(STATUS "[AUDIO] Ogg Vorbis enabled: stb_vorbis")
    list(APPEND REMINISCENCE_COMPILE_OPTS -DUSE_STB_VORBIS)
else()
    message(STATUS "[AUDIO] Ogg Vorbis enabled: tremor (non-FPU)")
    include(FetchContent)
    FetchContent_Declare(
        tremor
        GIT_REPOSITORY https://gitlab.xiph.org/xiph/tremor.git
        GIT_TAG        820fb3237ea81af44c9cc468c8b4e20128e3e5ad
    )
    FetchContent_MakeAvailable(tremor)
    list(APPEND REMINISCENCE_INCLUDE_DIRS ${tremor_SOURCE_DIR})
    list(APPEND REMINISCENCE_COMPILE_OPTS -DUSE_TREMOR)
    find_package(PkgConfig)
    pkg_check_modules(OGG ogg)
    list(APPEND REMINISCENCE_LIBRARIES ${OGG_LIBRARIES})
    list(APPEND REMINISCENCE_INCLUDE_DIRS ${OGG_INCLUDE_DIRS})
    list(APPEND REMINISCENCE_LINK_DIRS ${OGG_LIBRARY_DIRS})
endif()
