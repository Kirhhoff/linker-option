#include <stdio.h>
#include "static_lib_part1.h"

void static_part1_routine()
{
    printf("static_part1_routine\n");
}

__attribute__((constructor)) void static_part1_init()
{
    printf("static_part1_init\n");
}