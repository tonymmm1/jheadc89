cmake_minimum_required(VERSION 3.12)

project(jheadc89 C)

set(CMAKE_C_STANDARD 90)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_EXE_LINKER_FLAGS "-lm")

if (CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options(-Wall -Wdeclaration-after-statement)
endif()

if (NOT WIN32)
    add_compile_definitions(_POSIX_C_SOURCE=200809L)
endif()

if (WIN32 AND BUILD_SHARED_LIBS)
	set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include) 

set(${PROJECT_NAME}_SOURCES
	${CMAKE_CURRENT_LIST_DIR}/include/jhead.h
	${CMAKE_CURRENT_LIST_DIR}/include/iptc.h
        ${CMAKE_CURRENT_LIST_DIR}/src/jpgfile.c
        ${CMAKE_CURRENT_LIST_DIR}/src/jpgqguess.c
        ${CMAKE_CURRENT_LIST_DIR}/src/paths.c
        ${CMAKE_CURRENT_LIST_DIR}/src/exif.c
        ${CMAKE_CURRENT_LIST_DIR}/src/iptc.c
        ${CMAKE_CURRENT_LIST_DIR}/src/gpsinfo.c
        ${CMAKE_CURRENT_LIST_DIR}/src/makernote.c
        ${CMAKE_CURRENT_LIST_DIR}/src/pngfile.c
        ${CMAKE_CURRENT_LIST_DIR}/src/webpfile.c
        ${CMAKE_CURRENT_LIST_DIR}/src/imgfile.c)

if (WIN32)
    list(APPEND ${PROJECT_NAME}_SOURCES
        ${CMAKE_CURRENT_LIST_DIR}/src/myglob.c
        ${CMAKE_CURRENT_LIST_DIR}/src/winfileopen.c)
endif()

add_library(${PROJECT_NAME} ${${PROJECT_NAME}_SOURCES})

add_executable(jhead
	${CMAKE_CURRENT_LIST_DIR}/src/jhead.c
	${${PROJECT_NAME}_SOURCES}
	)

target_link_libraries(jhead ${PROJECT_NAME})
