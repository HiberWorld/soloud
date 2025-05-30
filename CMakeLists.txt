cmake_minimum_required(VERSION 3.11 FATAL_ERROR)

project("SoLoud" LANGUAGES C CXX)

if (HBR_IOS OR HBR_MACOS)
	enable_language(OBJC OBJCXX)
endif()

set(INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
set(SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)

if (HBR_WINDOWS)
	string(REPLACE "/W4" "" TMP1 ${CMAKE_CXX_FLAGS})
	set(CMAKE_CXX_FLAGS "${TMP1} /W3")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /DWITH_MINIAUDIO /DWITH_NOSOUND /DWITH_NULL /DWITH_WASAPI /DWITH_XAUDIO2")

	string(REPLACE "/W4" "" TMP2 ${CMAKE_C_FLAGS})
	set(CMAKE_C_FLAGS "${TMP2} /W3")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /DWITH_MINIAUDIO /DWITH_NOSOUND /DWITH_NULL /DWITH_WASAPI /DWITH_XAUDIO2")
elseif(HBR_EMSCRIPTEN OR HBR_LINUX OR HBR_ANDROID)
	string(REPLACE "-Wall -Wextra" "" TMP1 ${CMAKE_CXX_FLAGS})
	set(CMAKE_CXX_FLAGS "${TMP1} ")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -w -DWITH_MINIAUDIO -DWITH_NOSOUND -DWITH_NULL")

	string(REPLACE "-Wall -Wextra" "" TMP2 ${CMAKE_C_FLAGS})
	set(CMAKE_C_FLAGS "${TMP2} ")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w -DWITH_MINIAUDIO -DWITH_NOSOUND -DWITH_NULL")
elseif (HBR_IOS OR HBR_MACOS)
	string(REPLACE "-Wall -Wextra" "" TMP1 ${CMAKE_CXX_FLAGS})
	set(CMAKE_CXX_FLAGS "${TMP1} ")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -w -DWITH_MINIAUDIO -DWITH_NOSOUND -DWITH_NULL")

	string(REPLACE "-Wall -Wextra" "" TMP2 ${CMAKE_C_FLAGS})
	set(CMAKE_C_FLAGS "${TMP2} ")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -w -DWITH_MINIAUDIO -DWITH_NOSOUND -DWITH_NULL")

	set(CMAKE_OBJC_FLAGS "${CMAKE_C_FLAGS}")
	set(CMAKE_OBJCXX_FLAGS "${CMAKE_CXX_FLAGS}")
else()
	message(FATAL_ERROR "Unimplemented")
endif()

set(SRC_FILES
	${INCLUDE_DIR}/soloud.h
	${INCLUDE_DIR}/soloud_audiosource.h
	${INCLUDE_DIR}/soloud_bassboostfilter.h
	${INCLUDE_DIR}/soloud_biquadresonantfilter.h
	${INCLUDE_DIR}/soloud_bus.h
	${INCLUDE_DIR}/soloud_dcremovalfilter.h
	${INCLUDE_DIR}/soloud_echofilter.h
	${INCLUDE_DIR}/soloud_error.h
	${INCLUDE_DIR}/soloud_fader.h
	${INCLUDE_DIR}/soloud_fft.h
	${INCLUDE_DIR}/soloud_fftfilter.h
	${INCLUDE_DIR}/soloud_file.h
	${INCLUDE_DIR}/soloud_file_hack_off.h
	${INCLUDE_DIR}/soloud_file_hack_on.h
	${INCLUDE_DIR}/soloud_filter.h
	${INCLUDE_DIR}/soloud_flangerfilter.h
	${INCLUDE_DIR}/soloud_freeverbfilter.h
	${INCLUDE_DIR}/soloud_internal.h
	${INCLUDE_DIR}/soloud_lofifilter.h
	${INCLUDE_DIR}/soloud_misc.h
	${INCLUDE_DIR}/soloud_noise.h
	${INCLUDE_DIR}/soloud_queue.h
	${INCLUDE_DIR}/soloud_robotizefilter.h
	${INCLUDE_DIR}/soloud_speech.h
	${INCLUDE_DIR}/soloud_thread.h
	${INCLUDE_DIR}/soloud_vizsn.h
	${INCLUDE_DIR}/soloud_wav.h
	${INCLUDE_DIR}/soloud_waveshaperfilter.h
	${INCLUDE_DIR}/soloud_wavstream.h
	${INCLUDE_DIR}/soloud_eqfilter.h

	${SRC_DIR}/audiosource/noise/soloud_noise.cpp
	${SRC_DIR}/audiosource/speech/darray.cpp
	${SRC_DIR}/audiosource/speech/darray.h
	${SRC_DIR}/audiosource/speech/klatt.cpp
	${SRC_DIR}/audiosource/speech/klatt.h
	${SRC_DIR}/audiosource/speech/resonator.cpp
	${SRC_DIR}/audiosource/speech/resonator.h
	${SRC_DIR}/audiosource/speech/soloud_speech.cpp
	${SRC_DIR}/audiosource/speech/tts.cpp
	${SRC_DIR}/audiosource/speech/tts.h
	${SRC_DIR}/audiosource/vizsn/soloud_vizsn.cpp
	${SRC_DIR}/audiosource/wav/dr_flac.h
	${SRC_DIR}/audiosource/wav/dr_impl.cpp
	${SRC_DIR}/audiosource/wav/dr_mp3.h
	${SRC_DIR}/audiosource/wav/dr_wav.h
	${SRC_DIR}/audiosource/wav/soloud_wav.cpp
	${SRC_DIR}/audiosource/wav/soloud_wavstream.cpp
	${SRC_DIR}/audiosource/wav/stb_vorbis.c
	${SRC_DIR}/audiosource/wav/stb_vorbis.h

	${SRC_DIR}/backend/nosound/soloud_nosound.cpp
	${SRC_DIR}/backend/null/soloud_null.cpp
	${SRC_DIR}/backend/wasapi/soloud_wasapi.cpp
	${SRC_DIR}/backend/xaudio2/soloud_xaudio2.cpp

	${SRC_DIR}/core/soloud.cpp
	${SRC_DIR}/core/soloud_audiosource.cpp
	${SRC_DIR}/core/soloud_bus.cpp
	${SRC_DIR}/core/soloud_core_3d.cpp
	${SRC_DIR}/core/soloud_core_basicops.cpp
	${SRC_DIR}/core/soloud_core_faderops.cpp
	${SRC_DIR}/core/soloud_core_filterops.cpp
	${SRC_DIR}/core/soloud_core_getters.cpp
	${SRC_DIR}/core/soloud_core_setters.cpp
	${SRC_DIR}/core/soloud_core_voicegroup.cpp
	${SRC_DIR}/core/soloud_core_voiceops.cpp
	${SRC_DIR}/core/soloud_fader.cpp
	${SRC_DIR}/core/soloud_fft.cpp
	${SRC_DIR}/core/soloud_fft_lut.cpp
	${SRC_DIR}/core/soloud_file.cpp
	${SRC_DIR}/core/soloud_filter.cpp
	${SRC_DIR}/core/soloud_misc.cpp
	${SRC_DIR}/core/soloud_queue.cpp
	${SRC_DIR}/core/soloud_thread.cpp

	${SRC_DIR}/filter/soloud_bassboostfilter.cpp
	${SRC_DIR}/filter/soloud_biquadresonantfilter.cpp
	${SRC_DIR}/filter/soloud_dcremovalfilter.cpp
	${SRC_DIR}/filter/soloud_echofilter.cpp
	${SRC_DIR}/filter/soloud_fftfilter.cpp
	${SRC_DIR}/filter/soloud_flangerfilter.cpp
	${SRC_DIR}/filter/soloud_freeverbfilter.cpp
	${SRC_DIR}/filter/soloud_lofifilter.cpp
	${SRC_DIR}/filter/soloud_robotizefilter.cpp
	${SRC_DIR}/filter/soloud_waveshaperfilter.cpp
	${SRC_DIR}/filter/soloud_eqfilter.cpp
)

if (HBR_MACOS OR HBR_IOS)
    list(APPEND SRC_FILES ${CMAKE_CURRENT_SOURCE_DIR}/hbr/soloud_miniaudio_objc.mm)
else()
    list(APPEND SRC_FILES ${SRC_DIR}/backend/miniaudio/soloud_miniaudio.cpp)
endif()

add_library(SoLoud ${SRC_FILES})

target_include_directories(SoLoud PUBLIC
	${INCLUDE_DIR}
)

if (HBR_MACOS OR HBR_IOS)
	target_link_libraries(SoLoud "-framework AudioToolbox")
	target_link_libraries(SoLoud "-framework AVFoundation")
endif()
