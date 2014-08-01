typedef struct roots_result {
    int   success;
    float left;
    float right;
} roots_result;

roots_result root_finder(float a, float b, float c);
