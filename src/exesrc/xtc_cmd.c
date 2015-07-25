#include <stdio.h>
#include <malloc.h>
#include <dlfcn.h>
#include "xtc/xtc.h"

int main(int argc, char* argv[])
{
    void* lib_handle = dlopen("libxtc.so", RTLD_LAZY);
    if (!lib_handle)
    {
        fprintf(stderr, "Unable to load library.\n");
        return 1;
    }

    char* (*xtc_colorize)(char*);
    xtc_colorize = dlsym(lib_handle, "xtc_colorize");
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
