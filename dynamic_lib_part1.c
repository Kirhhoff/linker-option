#include <stdio.h>
#include "dynamic_lib_part1.h"

void dynamic_part1_routine()
{
    printf("dynamic_part1_routine\n");
}

__attribute__((constructor)) void dynamic_part1_init()
{
    printf("dynamic_part1_init\n");
}