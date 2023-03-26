#include <stdio.h>

__attribute__((constructor)) void static_part2_init()
{
    printf("static_part2_init\n");
}