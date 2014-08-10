#include <string.h>
#include <malloc.h>

#include "strextra.h"

void appendstr(char** left_ptr, const char* right)
{
    int len1 = 0;
    int len2;
    char* left = *left_ptr;
    if (left != NULL)
        len1 = strlen(left);
    len2 = strlen(right);
    char* res = malloc(sizeof(char) * (len1+len2+1));
    res[0] = 0;
    if (left != NULL)
        strcpy(res, left);
    strcat(res, right);
    if (left != NULL)
        free(left);
    *left_ptr = res;
}

char* strdup(char* s)
{
    if (s == NULL)
        return NULL;
    char* res = (char*)malloc(sizeof(char) * (strlen(s)+1));
    strcpy(res, s);
    return res;
}

char* new_itoa(int value)
{
    char result[50];
    sprintf(result, "%d", value);
    return strdup(result);
}
