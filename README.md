# libDCL

FOSS lib for PKWare's DCL compresseion algorithm, supports both compression and decompression.

Combines blast.c and implode.c into one easy to use library, should also make bindings to other languages easier.

## Build

There is a makefile, you can do it!

## Examples
### Decompression
```c
#include <stdio.h>
#include "libDCL.h"

//-- both should give the same output
//char compressedData[] = { 0x00, 0x04, 0x82, 0x24, 0x25, 0x8F, 0x80, 0x7F };
char compressedData[] = { 0x00, 0x04, 0x82, 0x24, 0x25, 0x0F, 0x00, 0x01, 0xFF };

char decompressedData[100];
int decompressedLength = 0;

int err = decompressBytes(
    compressedData, sizeof(compressedData),
    decompressedData, &decompressedLength
);
printf("decompress return value: %i \n", err);

if (err != 0) {
    printf("decompression failed!");
    return;
}

// should be: AIAIAIAIAIAIA with length 14
printf("decompressed data: %s with length %i \n", decompressedData, decompressedLength);
```

### Compression
```c
#include <stdio.h>
#include "libDCL.h"

char orgData[] = "AIAIAIAIAIAIA";

char compressedData[sizeof(orgData)*2];
int compressedLength = 0;

int err = compressBytes(
    orgData, sizeof(orgData),
    compressedData, &compressedLength,
    CMP_BINARY, CMP_IMPLODE_DICT_SIZE3
);
printf("compress return value: %i \n", err);

if (err != CMP_NO_ERROR) {
    printf("decompression failed!");
    return;
}

// should be 00:06:82:24:25:0F:00:04:FC:03 with length 10
printf("decompressed data: ");
for (int i = 0; i < compressedLength; i++) {
    if (i > 0) printf(":");
    printf("%02X", (unsigned char)compressedData[i]);
}
printf(" with length %i \n", compressedLength);
```

### Credits

- [blast.c by mark adler](https://github.com/madler/zlib/tree/master/contrib/blast)
- [implode.c by Ladislav Zezula](https://github.com/ladislav-zezula/StormLib/blob/master/src/pklib/implode.c)
