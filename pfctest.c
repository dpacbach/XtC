#include <stdio.h>
#include <malloc.h>
#include "pfc.h"

int main()
{
    char* test = "<coloredtext>Here <red><b>is</b></red> <b>some</b> <red>text</red> to <b><green>colorize</green></b>...<b>Here is <blue>some</blue> more</b> text to <yellow><b>co</b><red>lori</red>ze</yellow>.</coloredtext>";

    printf("Hello, this is a test of printf color.\n");

    printf("Input: %s\n", test);

    char* result = colorize(test);

    if (!result)
    {
        printf("Failed to colorize.\n");
        return 1;
    }

    printf("Successfully colorized text: %s\n", result);

    free(result);

    return 0;
}
