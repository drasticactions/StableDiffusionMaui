ROOT=$(PWD)
PROJECT_ROOT=$(ROOT)/external/stable-diffusion.cpp
BUILD_TYPE=Release
CMAKE_PARAMETERS=-DCMAKE_BUILD_TYPE=$(BUILD_TYPE)

clean:
	rm -rf build
	rm -rf runtimes

macos:
	rm -rf build/macos
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DSD_METAL=ON -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -B $(ROOT)/build/macos
	cmake --build build/macos
	mkdir -p runtimes/macos
	cp $(ROOT)/build/macos/bin/ggml-metal.metal runtimes/macos/ggml-metal.metal
	cp $(ROOT)/build/macos/bin/ggml-common.h runtimes/macos/ggml-common.h
	cp $(ROOT)/build/macos/bin/libstable-diffusion.dylib runtimes/macos/libstable-diffusion.dylib

maccatalyst_x64:
	rm -rf build/maccatalyst-x64
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=MAC_CATALYST -DSD_METAL=ON -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -B $(ROOT)/build/maccatalyst-x64
	cmake --build build/maccatalyst-x64
	mkdir -p runtimes/maccatalyst-x64
	cp $(ROOT)/build/maccatalyst-x64/bin/ggml-metal.metal runtimes/maccatalyst-x64/ggml-metal.metal
	cp $(ROOT)/build/maccatalyst-x64/bin/ggml-common.h runtimes/maccatalyst-x64/ggml-common.h
	cp $(ROOT)/build/maccatalyst-x64/bin/libstable-diffusion.dylib runtimes/maccatalyst-x64/libstable-diffusion.dylib

maccatalyst_arm64:
	rm -rf build/maccatalyst-arm64
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=MAC_CATALYST_ARM64 -DSD_METAL=ON -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -B $(ROOT)/build/maccatalyst-arm64
	cmake --build build/maccatalyst-arm64
	mkdir -p runtimes/maccatalyst-arm64
	cp $(ROOT)/build/maccatalyst-arm64/bin/ggml-metal.metal runtimes/maccatalyst-arm64/ggml-metal.metal
	cp $(ROOT)/build/maccatalyst-arm64/bin/ggml-common.h runtimes/maccatalyst-arm64/ggml-common.h
	cp $(ROOT)/build/maccatalyst-arm64/bin/libstable-diffusion.dylib runtimes/maccatalyst-arm64/libstable-diffusion.dylib

lipo_maccatalyst:
	mkdir -p runtimes/maccatalyst
	lipo -create runtimes/maccatalyst-x64/libstable-diffusion.dylib runtimes/maccatalyst-arm64/libstable-diffusion.dylib -output runtimes/maccatalyst/libstable-diffusion.dylib
	cp $(ROOT)/build/maccatalyst-x64/bin/ggml-metal.metal runtimes/maccatalyst/ggml-metal.metal
	cp $(ROOT)/build/maccatalyst-x64/bin/ggml-common.h runtimes/maccatalyst/ggml-common.h

ios_simulator_x64:
	rm -rf build/ios-simulator-x64
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSD_METAL=ON -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -B $(ROOT)/build/ios-simulator-x64
	cmake --build build/ios-simulator-x64
	mkdir -p runtimes/ios-simulator-x64
	cp $(ROOT)/build/ios-simulator-x64/bin/ggml-metal.metal runtimes/ios-simulator-x64/ggml-metal.metal
	cp $(ROOT)/build/ios-simulator-x64/bin/ggml-common.h runtimes/ios-simulator-x64/ggml-common.h
	cp $(ROOT)/build/ios-simulator-x64/bin/libstable-diffusion.dylib runtimes/ios-simulator-x64/libstable-diffusion.dylib

ios_simulator_arm64:
	rm -rf build/ios-simulator-arm64
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=SIMULATORARM64 -DSD_METAL=ON -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -B $(ROOT)/build/ios-simulator-arm64
	cmake --build build/ios-simulator-arm64
	mkdir -p runtimes/ios-simulator-arm64
	cp $(ROOT)/build/ios-simulator-arm64/bin/ggml-metal.metal runtimes/ios-simulator-arm64/ggml-metal.metal
	cp $(ROOT)/build/ios-simulator-arm64/bin/ggml-common.h runtimes/ios-simulator-arm64/ggml-common.h
	cp $(ROOT)/build/ios-simulator-arm64/bin/libstable-diffusion.dylib runtimes/ios-simulator-arm64/libstable-diffusion.dylib

lipo_ios_simulator:
	mkdir -p runtimes/ios-simulator
	lipo -create runtimes/ios-simulator-x64/libstable-diffusion.dylib runtimes/ios-simulator-arm64/libstable-diffusion.dylib -output runtimes/ios-simulator/libstable-diffusion.dylib
	cp $(ROOT)/build/ios-simulator-x64/bin/ggml-metal.metal runtimes/ios-simulator/ggml-metal.metal
	cp $(ROOT)/build/ios-simulator-x64/bin/ggml-common.h runtimes/ios-simulator/ggml-common.h

ios:
	rm -rf build/ios
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DCMAKE_TOOLCHAIN_FILE=../../ios.toolchain.cmake -DPLATFORM=OS64 -DSD_METAL=ON -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -B $(ROOT)/build/ios
	cmake --build build/ios
	mkdir -p runtimes/ios
	cp $(ROOT)/build/ios/bin/ggml-metal.metal runtimes/ios/ggml-metal.metal
	cp $(ROOT)/build/ios/bin/ggml-common.h runtimes/ios/ggml-common.h
	cp $(ROOT)/build/ios/bin/libstable-diffusion.dylib runtimes/ios/libstable-diffusion.dylib
