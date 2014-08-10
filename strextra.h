#ifndef __STREXTRA__
#define __STREXTRA__

/*
 * This function will make a new string which is the
 * concatenation of left and right.  It will then free
 * the memory pointed to by *left_ptr and will replace
 * this pointer with a pointer to the new string
 *
 * If *left_ptr == NULL then the new string will be
 * just that pointed to by right
 */
void appendstr(char** left_ptr, const char* right);

char* strdup(char* s);

char* new_itoa(int value);

#endif
