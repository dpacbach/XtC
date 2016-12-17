#include <stdio.h>
#ifdef OS_OSX
#include <stdlib.h>
#else
#include <malloc.h>
#endif
#include <dlfcn.h>
#include "xtc/xtc.h"

#define STRINGIFY_(x) #x
#define STRINGIFY(x)  STRINGIFY_(x)

char const* lib_name = "libxtc." STRINGIFY(SO_EXT);

int main()
{
    void* lib_handle = dlopen(lib_name, RTLD_LAZY);
    if (!lib_handle)
    {
        fprintf(stderr, "Unable to load library.\n");
        return 1;
    }

    char* (*xtc_colorize)(char*);
    xtc_colorize = (xtc_colorize_t)dlsym(lib_handle, "xtc_colorize");
    char* error = dlerror();
    if (error)
    {
        fprintf(stderr, "\nFailed to find symbol!");
        fprintf(stderr, "\n%s\n", error);
        return 1;
    }
    
    char message[1024];
    while (1)
    {
        char* s = fgets(message, 1024, stdin);    
        if (!s)
            break;
        char* result = xtc_colorize(message);
        printf("%s", result);
        fflush(stdout); // Don't buffer the output lines
        free(result);
    }

    dlclose(lib_handle);
    return 0;
}
