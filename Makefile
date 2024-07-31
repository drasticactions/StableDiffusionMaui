ROOT=$(PWD)
PROJECT_ROOT=$(ROOT)/external/stable-diffusion.cpp
BUILD_TYPE=Release
CMAKE_PARAMETERS=-DCMAKE_BUILD_TYPE=$(BUILD_TYPE)

clean:
	rm -rf build
	rm -rf runtimes

macos:
	rm -rf build/macos
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -B $(ROOT)/build/macos
	cmake --build build/macos
	mkdir -p runtimes/macos
	cp $(ROOT)/build/macos/bin/ggml-metal.metal runtimes/macos/ggml-metal.metal
	cp $(ROOT)/build/macos/bin/ggml-common.h runtimes/macos/ggml-common.h
	cp $(ROOT)/build/macos/bin/libstable-diffusion.dylib runtimes/macos/libstable-diffusion.dylib

maccatalyst_x64:
	rm -rf build/maccatalyst-x64
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DGGML_METAL=OFF -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -DCMAKE_SYSTEM_PROCESSOR=x86_64 -DCMAKE_HOST_SYSTEM_PROCESSOR=x86_64 -DCMAKE_SYSTEM_NAME=Darwin -DCMAKE_OSX_ARCHITECTURES="x86_64" -DCMAKE_CXX_FLAGS="-target x86_64-apple-ios14.0-macabi" -DCMAKE_C_FLAGS="-target x86_64-apple-ios14.0-macabi" -B $(ROOT)/build/maccatalyst-x64
	cmake --build build/maccatalyst-x64
	mkdir -p runtimes/maccatalyst-x64
	cp $(ROOT)/build/maccatalyst-x64/bin/libstable-diffusion.dylib runtimes/maccatalyst-x64/libstable-diffusion.dylib

maccatalyst_arm64:
	rm -rf build/maccatalyst-arm64
	cmake $(PROJECT_ROOT) $(CMAKE_PARAMETERS) -DGGML_METAL=OFF -DBUILD_SHARED_LIBS=ON -DSD_BUILD_SHARED_LIBS=ON -DSD_STANDALONE=OFF -DSD_BUILD_EXAMPLES=OFF -DCMAKE_SYSTEM_PROCESSOR=arm -DCMAKE_HOST_SYSTEM_PROCESSOR=arm64 -DCMAKE_SYSTEM_NAME=Darwin -DCMAKE_OSX_ARCHITECTURES="arm64" -DCMAKE_CXX_FLAGS="-target arm64-apple-ios14.0-macabi" -DCMAKE_C_FLAGS="-target arm64-apple-ios14.0-macabi" -B $(ROOT)/build/maccatalyst-arm64
	cmake --build build/maccatalyst-arm64
	mkdir -p runtimes/maccatalyst-arm64
	cp $(ROOT)/build/maccatalyst-arm64/bin/libstable-diffusion.dylib runtimes/maccatalyst-arm64/libstable-diffusion.dylib

lipo_maccatalyst:
	mkdir -p runtimes/maccatalyst
	lipo -create runtimes/maccatalyst-x64/libstable-diffusion.dylib runtimes/maccatalyst-arm64/libstable-diffusion.dylib -output runtimes/maccatalyst/libstable-diffusion.dylib
