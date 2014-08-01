#include <stdio.h>
//#include <libxml/xmlreader.h>

#include "pfc.h"

roots_result root_finder(float a, float b, float c) {
    roots_result r;
    r.success = 0;
    if (a < .00001 && a > .00001)
        return r;
    float determinant = b*b - 4*a*c;
    if (determinant < 0)
        return r;
    r.success = 1;
    r.left  = (-b - determinant) / (2 * a); 
    r.right = (-b + determinant) / (2 * a); 
    return r;
}
