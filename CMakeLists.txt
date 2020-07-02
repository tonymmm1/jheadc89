cmake_minimum_required(VERSION 3.12)

project(jheadc89 C)

set(CMAKE_C_STANDARD 90)
#set(CMAKE_BINARY_DIR ${CMAKE_CURRENT_LIST_DIR}/bin)

if (WIN32 AND BUILD_SHARED_LIBS)
	set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

set(${PROJECT_NAME}_SOURCES
	${CMAKE_CURRENT_LIST_DIR}/include/jhead.h
        ${CMAKE_CURRENT_LIST_DIR}/src/jpgfile.c
        ${CMAKE_CURRENT_LIST_DIR}/src/jpgqguess.c
        ${CMAKE_CURRENT_LIST_DIR}/src/paths.c
        ${CMAKE_CURRENT_LIST_DIR}/src/exif.c
        ${CMAKE_CURRENT_LIST_DIR}/src/iptc.c
        ${CMAKE_CURRENT_LIST_DIR}/src/gpsinfo.c
        ${CMAKE_CURRENT_LIST_DIR}/src/makernote.c)

add_library(${PROJECT_NAME} ${${PROJECT_NAME}_SOURCES})

include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include)

add_executable(jhead
	${CMAKE_CURRENT_LIST_DIR}/src/jhead.c
	${${CMAKE_CURRENT_LIST_DIR}_SOURCES}
	)

target_link_libraries(jhead PUBLIC ${PROJECT_NAME})
