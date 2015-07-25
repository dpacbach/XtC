#include <stdio.h>
#include <malloc.h>
#include "xtc/xtc.h"

int main()
{
    char* test = "Here <red><b>is</b></red> <b>some</b> <red>text</red> to <b><green>colorize</green></b>...<b>Here is <blue>some</blue> more</b> text to <yellow><b>co</b><red>lori</red>ze</yellow>.<cyan>#####</cyan>";

    //printf("Input: %s\n", test);

    char* result = xtc_colorize(test);

    if (!result)
    {
        fprintf(stderr, "Failed to colorize.\n");
        return 1;
    }

    printf("Successfully colorized text: %s\n", result);

    free(result);

    return 0;
}
