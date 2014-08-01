#include <stdio.h>
#include "pfc.h"

int main()
{
    printf("\nHello, this is a test of printf color.\n");
    roots_result r;
    r = root_finder(1.0, -2.0, 1.0);
    if (!r.success) {
        printf("\nFailed to compute roots!\n");
        return 1;
    }
    printf("\nRoots are %f and %f\n", r.left, r.right);
    return 0;    
}
