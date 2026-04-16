include(GNUInstallDirs)

install(TARGETS reminiscence
        DESTINATION ${CMAKE_INSTALL_BINDIR}
        PERMISSIONS WORLD_READ WORLD_EXECUTE
                GROUP_READ GROUP_EXECUTE
                OWNER_READ OWNER_WRITE OWNER_EXECUTE
)
install(FILES ${DIST_PATH}/rs.cfg
        DESTINATION ${CMAKE_INSTALL_BINDIR}
        PERMISSIONS WORLD_READ WORLD_EXECUTE
                GROUP_READ GROUP_EXECUTE
                OWNER_READ OWNER_WRITE OWNER_EXECUTE
)

# if(UNIX AND NOT APPLE)
#     install(FILES ${DIST_PATH}/${FREEDESKTOP_APP_ID}.svg
#             DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/scalable/apps/
#             PERMISSIONS WORLD_READ
#                         GROUP_READ
#                         OWNER_READ OWNER_WRITE OWNER_EXECUTE
#     )
#     install(FILES ${DIST_PATH}/linux/${FREEDESKTOP_APP_ID}.metainfo.xml
#             DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/metainfo/
#             PERMISSIONS WORLD_READ
#                         GROUP_READ
#                         OWNER_READ OWNER_WRITE OWNER_EXECUTE
#     )
#     install(FILES ${DIST_PATH}/linux/${FREEDESKTOP_APP_ID}.desktop
#             DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications/
#             PERMISSIONS WORLD_READ WORLD_EXECUTE
#                         GROUP_READ GROUP_EXECUTE
#                         OWNER_READ OWNER_WRITE OWNER_EXECUTE
#     )
# endif()
