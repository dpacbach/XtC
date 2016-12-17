#include <stdio.h>
#ifdef OS_OSX
#include <stdlib.h>
#else
#include <malloc.h>
#endif
#include "xtc/xtc.h"

int main()
{
    char* test = "Here <red><b>is</b></red> <b>some</b> <red>text</red> to <b><green>colorize</green></b>...<b>Here is <blue>some</blue> more</b> text to <yellow><b>co</b><red>lori</red>ze</yellow>.<cyan>#####</cyan>";

    char* result = xtc_colorize(test);

    if (!result)
    {
        fprintf(stderr, "Failed to colorize.\n");
        return 1;
    }

    printf("Successfully colorized text:\n\n%s\n", result);

    free(result);

    return 0;
}
