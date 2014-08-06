#include <stdio.h>
#include "pfc.h"

int main()
{
    char* test = "<coloredtext>yyy<red>xxx</red>iiiii<blue>nothing<insideblue>abc</insideblue>zyx<alsoinside>hello</alsoinside>_yo</blue>aaa<yellow>nnn</yellow>ppp</coloredtext>";

    printf("Hello, this is a test of printf color.\n");
    printf("Input: %s\n", test);

    char* result = get_blue(test);

    if (!result)
    {
        printf("Failed to get blue text.\n");
        return 1;
    }

    printf("Successfully retrieved text: %s\n", result);
    return 0;    
}
