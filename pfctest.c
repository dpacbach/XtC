#include <stdio.h>
#include <malloc.h>
#include "pfc.h"

int main()
{
    char* test = "<coloredtext>Here <red><b>is</b></red> <b>some</b> <red>text</red> to <b><red>colorize</red></b>...<b>Here is <red>some</red> more</b> text to colorize.</coloredtext>";

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
