#include <stdio.h>

__attribute__((constructor)) void dynamic_part2_init()
{
    printf("dynamic_part2_init\n");
}