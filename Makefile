all: linux windows

linux: folder
	gcc -fPIC -shared -o build/libDCL.so src/implode.c src/blast.c

windows: folder
	x86_64-w64-mingw32-gcc -fPIC -shared -o build/libDCL.dll src/implode.c src/blast.c

folder:
	-mkdir build